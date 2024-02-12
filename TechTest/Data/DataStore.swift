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
    private(set) var slots: [Date: [Slot]] = [:]
    private(set) var isUpdating: Bool = false
    
    var selectedDate: Date?
    
    @MainActor
    func update() async throws {
        Logger.data.info("Updating Schedule")
        
        isUpdating = true
        
        let slots = try await API.retrieveSchedule()
        let sortedSlots = slots.sorted(by: { $0.date < $1.date })
        
        let splitSlots: [Date: [Slot]] = sortedSlots.reduce(into: [:]) { results, slot in
            guard let midday = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: slot.date) else { return }
            
            var slots = results[midday] ?? []
            slots.append(slot)
            results[midday] = slots
        }
        
        self.slots = splitSlots
        selectedDate = dates.first
        
        isUpdating = false
    }
    
    var dates: [Date] {
        slots.keys.sorted()
    }
}
