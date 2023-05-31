//
//  GuideModel.swift
//  GuideChallenge
//
//  Created by Joseph Pecoraro on 5/30/23.
//

import Foundation

struct GuidesNetworkResponse {
    let total: String
    let data: [Guide]
}

struct Guide {
    let startDate: Date
    let endDate: Date
    let name: String
    /// /guide/27558
    let url: String
    let venue: Venue?
    let objType: String // TODO: Should probably be an enum?
    let icon: URL
}

struct Venue {
    let city: String?
    let state: String?
}

extension GuidesNetworkResponse : Codable { }

extension Guide : Codable, Equatable, Hashable { }

extension Venue : Codable, Equatable, Hashable { }
