//
//  APITests.swift
//  TechTestTests
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import XCTest
@testable import TechTest
import API

final class APITests: XCTestCase {
    func testLoadingSchedule() async throws {
        /// When
        let slots = try await API.retrieveSchedule()

        /// Then
        XCTAssertEqual(slots.count, 28)
    }
    
    func testLoadingScheduleActivity() async throws {
        /// When
        let slots = try await API.retrieveSchedule()

        /// Then
        let slot = slots[0]
        guard let activity = slot.activity else { XCTFail("Expected to find an Activity on this Slot"); return }

        XCTAssertEqual(slot.id.uuidString, "98EF4AC4-6C9A-4240-B9D5-DFA513267413")
        XCTAssertEqual(dateFormatter.string(from: slot.date), "09/10/2023, 09:30")
        XCTAssertEqual(slot.duration, 75)

        XCTAssertEqual(activity.title, "Registration & Breakfast")
        XCTAssertEqual(activity.subtitle, "Time to check in 🎟")
        XCTAssertEqual(activity.description, "The doors at The Playhouse will open at 8:30 AM and it's time to register, then once you have your badge you can check out the swag and T-Shirts. \r\nPlease bring along your QR code ticket for prompt entry and nothing else is required. \r\nThe SwiftLeeds team will greet you along with a fresh breakfast to start the first day.")
        XCTAssertEqual(activity.image, "https://swiftleeds-speakers.s3.eu-west-2.amazonaws.com/3B000D4F-FBE1-4732-8F6A-EC1EE2127AB6-3893D677-2CA2-4BD5-AE1D-F9F69CE85139-LP_BuildingProgress_Aug2019-7-David-Lindsay-Photographer-scaled.jpeg")
        XCTAssertEqual(activity.metadataURL, "")
    }

    func testLoadingSchedulePresentation() async throws {
        /// When
        let slots = try await API.retrieveSchedule()

        /// Then
        let slot = slots[2]
        guard let presentation = slot.presentation else { XCTFail("Expected to find a Presentation on this Slot"); return }
        guard let speaker = presentation.speakers.first else { XCTFail("Expected to find a Speaker on this Presentation"); return }

        XCTAssertEqual(slot.id.uuidString, "376BDB39-233E-4285-9120-75D330E6D15F")
        XCTAssertEqual(dateFormatter.string(from: slot.date), "09/10/2023, 11:00")
        XCTAssertEqual(slot.duration, 45)

        XCTAssertEqual(presentation.title, "Driving Success with UX: Unlocking Your iOS App's Full Potential")
        XCTAssertEqual(presentation.synopsis, "In this talk, we’ll explore how good UX design can drive business results for iOS apps, and share best practices for integrating UX design into your app development process.\r\n\r\nAs iOS development continues to evolve and become more competitive, it's increasingly important for businesses to focus on creating great user experiences. In this talk, I will share real-world examples of how good UX design has driven business results for iOS apps, including increased user engagement, higher conversion rates, and improved brand perception.\r\n\r\nI will also provide practical tips and strategies for incorporating UX design into your iOS development process, from conducting user research to designing intuitive user interfaces. Attendees will leave with a deeper understanding of the value of UX in iOS development, as well as actionable insights they can use to improve their own app design and development practices.")
        XCTAssertEqual(presentation.slidoURL, "https://app.sli.do/event/jHmthXSatH6w4BUEyjpDPa")
        XCTAssertEqual(presentation.videoURL, "https://www.youtube.com/watch?v=RZFeb5fD49s")

        XCTAssertEqual(speaker.name, "Richie Flores")
        XCTAssertEqual(speaker.biography, "Hello World! I am a principal software engineer and iOS aficionado with a passion for designing impactful user experiences. With over 7 years of experience building software products, I have seen firsthand the difference that good UX design can make in driving business results. I believe that the key to creating successful software products lies in understanding the needs and pain points of users, and designing intuitive interfaces that make it easy for them to achieve their goals. Good UX design can make a difference in the AppStore by driving business results such as increased user engagement, higher conversion rates, and improved brand perception.")
        XCTAssertEqual(speaker.profileImage, "https://swiftleeds-speakers.s3.eu-west-2.amazonaws.com/7A6E0452-E3F3-4FE7-A645-88D8A6B3DFA6-richie-flores.jpg")
        XCTAssertEqual(speaker.organisation, "Northrop Grumman")
        XCTAssertEqual(speaker.twitter, "richiexflores")
    }

    // MARK: - Custom DateFormatter
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
