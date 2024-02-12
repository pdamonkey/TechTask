//
//  DataStore.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import Foundation
import OSLog
import SwiftUI

@Observable
final class DataStore {
    private(set) var slots: [Slot] = []
    private(set) var isUpdating: Bool = false
    
    private static let baseAPI = "https://swiftleeds.co.uk/api"
    
    @MainActor
    func update() async throws {
        Logger.data.info("Updating Schedule")
        
        isUpdating = true
        
        let slots = try await retrieveSchedule()
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
    
    private func retrieveSchedule() async throws -> [Slot] {
        let slots: [Slot]

        if ProcessInfo.isMockingData || ProcessInfo.isRunningUnitTest {
            Logger.data.debug("Using mocked file for Schedule")
            let item: Schedule = try loadJSON(filename: "schedule")
            slots = item.data.slots
        } else {
            Logger.data.info("Retrieving Schedule")
            let item: Schedule = try await retrieveItem(for: "\(Self.baseAPI)/v1/schedule?event=2D951908-1679-4D02-944B-54579698888B")
            slots = item.data.slots
        }
        
        return slots
    }
    
    private func retrieveItem<Item: Decodable>(for url: String) async throws -> Item {
        guard let url = URL(string: url) else {
            Logger.data.error("Invalid URL")
            throw NetworkError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
            guard response.statusCode != 304 else { throw NetworkError.notModified }
            guard 200...299 ~= response.statusCode else { throw NetworkError.invalidStatus }

            let item: Item = try decode(from: data)
            return item
        } catch {
            Logger.data.error("Could not retrieve data")
            throw NetworkError.couldNotRetrieveData
        }
    }

    private func decode<Item: Decodable>(from data: Data) throws -> Item {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            return try decoder.decode(Item.self, from: data)
        } catch {
            Logger.data.error("Could not decode the item: \(error.localizedDescription)")
            throw NetworkError.decoding(error)
        }
    }
    
    private func loadJSON<Item: Decodable>(filename: String) throws -> Item {
        guard let url = Bundle(for: type(of: self)).url(forResource: filename, withExtension: "json") else { throw NetworkError.invalidURL }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(Item.self, from: data)
        } catch let error as DecodingError {
            throw NetworkError.decoding(error)
        } catch {
            throw NetworkError.couldNotRetrieveData
        }
    }

    // MARK: - Network Error
    enum NetworkError: Error {
        case couldNotRetrieveData
        case invalidURL
        case invalidResponse
        case invalidStatus
        case decoding(Error)
        case notModified
    }
}

// MARK: - ProcessInfo helpers
extension ProcessInfo {
    static var isMockingData: Bool {
        ProcessInfo.processInfo.arguments.contains("MockData")
    }

    static var isRunningUnitTest: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}

// MARK: - Unit Test access helpers
#if DEBUG
// Testable extensions callable by unit tests
extension DataStore {
    func retrieveScheduleTest() async throws -> [Slot] {
        try await retrieveSchedule()
    }
}
#endif
