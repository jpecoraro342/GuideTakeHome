//
//  GuideListDataServiceTests.swift
//  GuideChallengeTests
//
//  Created by Joseph Pecoraro on 5/31/23.
//

import XCTest

class GuideListDataServiceTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testGetUpcomingGuides() async {
        let dataService = GuideListDataService(guideService: MockGuideService())
        
        let guideList = await dataService.getUpcomingGuides()
        
        XCTAssertEqual(guideList.startDates, [Date.today(), Date.today().plusDay()])
        XCTAssertEqual(guideList.upcomingGuides[Date.today()]?.count, 2)
        XCTAssertEqual(guideList.upcomingGuides[Date.today().plusDay()]?.count, 1)
        XCTAssertEqual(guideList.upcomingGuides[Date.today()]?[0].name, "Guide 2")
        XCTAssertEqual(guideList.upcomingGuides[Date.today().plusDay()]?[0].name, "Guide 1")
    }
}

class MockGuideService : GuideService {
    func getUpcomingGuides() async -> [Guide] {
        return [
            Guide(startDate: Date.today().plusDay(),
                  endDate: Date.today().plusDay(numDays: 2),
                  name: "Guide 1",
                  url: "/guide/1",
                  venue: Venue(city: nil, state: nil),
                  objType: "guide",
                  icon: URL(staticString: "https://s3.amazonaws.com/media/1/logo.png")),
            Guide(startDate: Date.today(),
                  endDate: Date.today().plusDay(),
                  name: "Guide 2",
                  url: "/guide/2",
                  venue: Venue(city: nil, state: nil),
                  objType: "guide",
                  icon: URL(staticString: "https://s3.amazonaws.com/media/2/logo.png")),
            Guide(startDate: Date.today(),
                  endDate: Date.today().plusDay(),
                  name: "Guide 3",
                  url: "/guide/3",
                  venue: Venue(city: nil, state: nil),
                  objType: "guide",
                  icon: URL(staticString: "https://s3.amazonaws.com/media/3/logo.png"))]
    }
}

private extension Date {
    static let day : TimeInterval = 24 * 60 * 60
    
    /// Date() but without the time component
    static func today() -> Date {
        let calender : Calendar = .current
        return calender.date(from: calender.dateComponents([.year, .month, .day], from: Date()))!
    }
    
    func plusDay(numDays: Int = 0) -> Date {
        return self.addingTimeInterval(Self.day)
    }
}
