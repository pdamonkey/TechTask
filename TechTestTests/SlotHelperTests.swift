//
//  SlotHelperTests.swift
//  TechTestTests
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import XCTest
@testable import TechTest
import API

final class SlotHelperTests: XCTestCase {
    func testSlotStartTime() async throws {
        /// Given
        let slot = try await API.retrieveSchedule()[0]
        
        /// When
        let startTime = slot.startTime
        
        /// Then
        XCTAssertEqual(startTime, "08:30")
    }
    
    func testSlotEndTime() async throws {
        /// Given
        let slot = try await API.retrieveSchedule()[0]
        
        /// When
        let endTime = slot.endTime
        
        /// Then
        XCTAssertEqual(endTime, "09:45")
    }
    
    func testSlotTitleForActivity() async throws {
        /// When
        let slot = try await API.retrieveSchedule()[0]
        
        /// Then
        XCTAssertEqual(slot.title, "Registration & Breakfast")
    }
    
    func testSlotTitleForPresentation() async throws {
        /// When
        let slot = try await API.retrieveSchedule()[2]
        
        /// Then
        XCTAssertEqual(slot.title, "Driving Success with UX: Unlocking Your iOS App's Full Potential")
    }
    
    func testSlotSubtitleForActivity() async throws {
        /// Wjhen
        let slot = try await API.retrieveSchedule()[0]
        
        /// Then
        XCTAssertEqual(slot.subtitle, "Time to check in 🎟")
    }
    
    func testSlotSubtitleForPresentation() async throws {
        /// When
        let slot = try await API.retrieveSchedule()[2]
        
        /// Then
        XCTAssertEqual(slot.subtitle, "Richie Flores (Northrop Grumman)")
    }
    
    func testSlotDetailsForActivity() async throws {
        /// When
        let slot = try await API.retrieveSchedule()[0]
        
        /// Then
        XCTAssertEqual(slot.details, "The doors at The Playhouse will open at 8:30 AM and it's time to register, then once you have your badge you can check out the swag and T-Shirts. \r\nPlease bring along your QR code ticket for prompt entry and nothing else is required. \r\nThe SwiftLeeds team will greet you along with a fresh breakfast to start the first day.")
    }
    
    func testSlotDetailsForPresentation() async throws {
        /// When
        let slot = try await API.retrieveSchedule()[2]
        
        /// Then
        XCTAssertEqual(slot.details, "In this talk, we’ll explore how good UX design can drive business results for iOS apps, and share best practices for integrating UX design into your app development process.\r\n\r\nAs iOS development continues to evolve and become more competitive, it's increasingly important for businesses to focus on creating great user experiences. In this talk, I will share real-world examples of how good UX design has driven business results for iOS apps, including increased user engagement, higher conversion rates, and improved brand perception.\r\n\r\nI will also provide practical tips and strategies for incorporating UX design into your iOS development process, from conducting user research to designing intuitive user interfaces. Attendees will leave with a deeper understanding of the value of UX in iOS development, as well as actionable insights they can use to improve their own app design and development practices.")
    }
    
    func testSlotAccessibilityLabelForActivity() async throws {
        /// When
        let slot = try await API.retrieveSchedule()[0]
        
        /// Then
        XCTAssertEqual(slot.accessibilityLabel, "08:30 till 09:45. Registration & Breakfast. Time to check in 🎟")
    }
    
    func testSlotAccessibilityLabelForPresentation() async throws {
        /// When
        let slot = try await API.retrieveSchedule()[2]
        
        /// Then
        XCTAssertEqual(slot.accessibilityLabel, "10:00 till 10:45. Driving Success with UX: Unlocking Your iOS App's Full Potential. Richie Flores (Northrop Grumman)")
    }
    
    func testSlotTypeForActivity() async throws {
        /// When
        let slot = try await API.retrieveSchedule()[0]
        
        /// Then
        XCTAssertEqual(slot.type, .activity)
    }
    
    func testSlotTypeForPresentation() async throws {
        /// When
        let slot = try await API.retrieveSchedule()[2]
        
        /// Then
        XCTAssertEqual(slot.type, .presentation)
    }
}
