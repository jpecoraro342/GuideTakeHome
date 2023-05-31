//
//  GuideNetworkService.swift
//  GuideChallenge
//
//  Created by Joseph Pecoraro on 5/30/23.
//

import Foundation
import os

class GuideNetworkService {
    // Since the instructions say not to use the full word in the app
    static let baseUrlString : StaticString =
"""
https://www.guide\
book.com/service/v2
"""
    
    var decoder : JSONDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyy"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }
    
    let baseUrl : URL = URL(staticString: baseUrlString)
    let urlSession : URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension GuideNetworkService : GuideService {
    func getUpcomingGuides() async -> [Guide] {
        // TODO: Move this path somewhere else if we need to use it again
        let url = baseUrl.appending(path: "/upcomingGuides")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            
            Logger.logger.debug("Response: \(String(data: data, encoding: .utf8) ?? "")")
            
            let response = try decoder.decode(GuidesNetworkResponse.self, from: data)
            
            return response.data
        } catch {
            // TODO: Bubble up this error/handle it appropriately
            Logger.logger.debug("Error while retrieving upcoming guides \(error)")
        }
        
        return []
    }
}

// TODO: Move this out of this class
extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}
