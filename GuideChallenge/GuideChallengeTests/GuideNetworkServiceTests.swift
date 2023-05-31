//
//  GuideNetworkServiceTests.swift
//  GuideChallengeTests
//
//  Created by Joseph Pecoraro on 5/30/23.
//

import XCTest

class GuideNetworkServiceTests: XCTestCase {
    var urlSession : URLSession?
    var baseUrl = URL(staticString: GuideNetworkService.baseUrlString)
    var dateFormatter : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyy"
        return dateFormatter
    }
    
    override func setUp() {
        let configuration : URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testGetUpcomingGuides() async throws {
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.baseUrl.appending(path: "/upcomingGuides"),
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
            return (response, upcomingGuides.data(using: .utf8)!)
        }
        
        let guideService = GuideNetworkService(urlSession: urlSession!)
        let guides = await guideService.getUpcomingGuides()
        
        XCTAssertEqual(guides.count, 2)
        XCTAssertEqual(guides[0],
                       Guide(startDate: dateFormatter.date(from: ("Jun 02, 2023"))!,
                             endDate: dateFormatter.date(from: ("Jun 04, 2023"))!,
                             name: "Gustavus Reunion Weekend 2023",
                             url: "/guide/192487",
                             venue: Venue(city: nil, state: nil),
                             objType: "guide",
                             icon: URL(staticString: "https://s3.amazonaws.com/media.guidebook.com/service/i0wLTo2eEJbcY8vKpYK0MhC1SBm8TSmb9f0waLrc/logo.png")),
                       "Guide with no venue")
        
        XCTAssertEqual(guides[1],
                       Guide(startDate: dateFormatter.date(from: ("Jun 02, 2023"))!,
                             endDate: dateFormatter.date(from: ("Jul 01, 2023"))!,
                             name: "Nats23",
                             url: "/guide/148668",
                             venue: Venue(city: "Raleigh", state: "North Carolina"),
                             objType: "guide",
                             icon: URL(staticString: "https://s3.amazonaws.com/media.guidebook.com/service/sCA5C25OCG0R2S2ScYzZSYviaKYl6ONrFhilLpEG/logo.png")),
                       "Guide with venue")
    }
}

let upcomingGuides = """
{
    "data": [
        {
            "url": "/guide/192487",
            "startDate": "Jun 02, 2023",
            "endDate": "Jun 04, 2023",
            "name": "Gustavus Reunion Weekend 2023",
            "icon": "https://s3.amazonaws.com/media.guidebook.com/service/i0wLTo2eEJbcY8vKpYK0MhC1SBm8TSmb9f0waLrc/logo.png",
            "venue": {},
            "objType": "guide",
            "loginRequired": false
        },
        {
            "url": "/guide/148668",
            "startDate": "Jun 02, 2023",
            "endDate": "Jul 01, 2023",
            "name": "Nats23",
            "icon": "https://s3.amazonaws.com/media.guidebook.com/service/sCA5C25OCG0R2S2ScYzZSYviaKYl6ONrFhilLpEG/logo.png",
            "venue": {
                "city": "Raleigh",
                "state": "North Carolina"
            },
            "objType": "guide",
            "loginRequired": false
        }
    ],
    "total": "2"
}
"""
