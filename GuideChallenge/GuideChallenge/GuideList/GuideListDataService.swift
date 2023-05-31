//
//  GuideListDataService.swift
//  GuideChallenge
//
//  Created by Joseph Pecoraro on 5/31/23.
//

import Foundation

class GuideListDataService {
    let guideService : GuideService
    
    init(guideService: GuideService = GuideNetworkService()) {
        self.guideService = guideService
    }
    
    func getUpcomingGuides() async -> GuideList {
        let upcomingGuides = await guideService.getUpcomingGuides()
        
        var startDates : Set<Date> = []
        var guides : [Date : [Guide]] = [:]
        
        for guide in upcomingGuides {
            startDates.insert(guide.startDate)
            
            var dateGuides = guides[guide.startDate, default: []]
            dateGuides.append(guide)
            
            guides[guide.startDate] = dateGuides
        }
        
        return GuideList(startDates: startDates.sorted(), upcomingGuides: guides)
    }
}
