//
//  GuideService.swift
//  GuideChallenge
//
//  Created by Joseph Pecoraro on 5/30/23.
//

import Foundation

protocol GuideService {
    func getUpcomingGuides() async -> [Guide]
}
