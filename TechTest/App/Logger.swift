//
//  Logger.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import Foundation
import OSLog

extension Logger {
    public static let app = Logger(subsystem: subsystem, category: "app")
    public static let data = Logger(subsystem: subsystem, category: "data")

    // Use the main subsystem for consistant logging
    private static var subsystem = Bundle.main.bundleIdentifier!
}
