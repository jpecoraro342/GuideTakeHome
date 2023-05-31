//
//  Logger.swift
//  GuideChallenge
//
//  Created by Joseph Pecoraro on 5/30/23.
//

import Foundation
import os

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let logger = Logger(subsystem: subsystem, category: "Application")
}
