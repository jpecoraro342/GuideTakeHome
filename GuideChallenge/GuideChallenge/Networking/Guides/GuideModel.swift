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

// TODO: depending on complexity, I'd like to use this model exclusively for the network response, then map it to a seperate domain object to be used elsewhere.
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
