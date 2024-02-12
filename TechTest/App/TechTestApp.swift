//
//  TechTestApp.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import OSLog
import SwiftUI

@main
struct TechTestApp: App {
    init() {
        URLCache.shared.memoryCapacity = 50_000_000
        URLCache.shared.diskCapacity = 500_000_000
        
        Logger.app.info("Initialised App")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
