//
//  DataStore.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import Foundation
import OSLog
import SwiftUI
import API

@Observable
final class DataStore {
    private(set) var slots: [Slot] = []
    private(set) var isUpdating: Bool = false
    
    @MainActor
    func update() async throws {
        Logger.data.info("Updating Schedule")
        
        isUpdating = true
        
        let slots = try await API.retrieveSchedule()
        self.slots = slots
        
        isUpdating = false
    }
    
    @MainActor
    func handleScenePhase(oldPhase: ScenePhase, newPhase: ScenePhase) async {
        switch newPhase {
        case .active:
            Logger.data.info("App is active")

            do {
                try await update()
            } catch {
                Logger.data.error("\(error.localizedDescription)")
            }
        case .inactive:
            Logger.data.info("App is inactive")
        case .background:
            Logger.data.info("App is in the background")
        @unknown default:
            Logger.data.error("App in unknown scene phase")
            fatalError("unknown scene phase")
        }
    }
}
