//
//  SampleData.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import Foundation
import API

extension Slot {
    static let samples = [
        Slot(id: UUID(), date: DateFormatter.iso.date(from: "2023-10-09T08:30:00Z")!, duration: 75, activity: .samples[0], presentation: nil),
        Slot(id: UUID(), date: DateFormatter.iso.date(from: "2023-10-09T09:45:00Z")!, duration: 10, activity: .samples[1], presentation: nil),
        Slot(id: UUID(), date: DateFormatter.iso.date(from: "2023-10-09T10:00:00Z")!, duration: 45, activity: nil, presentation: .samples[0]),
    ]

    static let sampleActivity = samples[0]
    static let samplePresentation = samples[2]
}

extension Slot.Activity {
    static let samples = [
        Slot.Activity(id: UUID(), title: "Registration & Breakfast", subtitle: "Time to check in 🎟", description: "The doors at The Playhouse will open at 8:30 AM and it's time to register, then once you have your badge you can check out the swag and T-Shirts. \r\nPlease bring along your QR code ticket for prompt entry and nothing else is required. \r\nThe SwiftLeeds team will greet you along with a fresh breakfast to start the first day.", image: "https://swiftleeds-speakers.s3.eu-west-2.amazonaws.com/3B000D4F-FBE1-4732-8F6A-EC1EE2127AB6-3893D677-2CA2-4BD5-AE1D-F9F69CE85139-LP_BuildingProgress_Aug2019-7-David-Lindsay-Photographer-scaled.jpeg", metadataURL: nil),
        Slot.Activity(id: UUID(), title: "Intro", subtitle: "", description: "Adam Rush will be hosting this years conference", image: "https://swiftleeds-speakers.s3.eu-west-2.amazonaws.com/0F7181CE-60CA-43A1-90AC-DC12913583BD-Adam-Headshot.jpg", metadataURL: nil),
    ]

    static let sample = samples[0]
}

extension Slot.Presentation {
    static let samples = [
        Slot.Presentation(id: UUID(), title: "Driving Success with UX: Unlocking Your iOS App's Full Potential", synopsis: "In this talk, we’ll explore how good UX design can drive business results for iOS apps, and share best practices for integrating UX design into your app development process.\r\n\r\nAs iOS development continues to evolve and become more competitive, it's increasingly important for businesses to focus on creating great user experiences. In this talk, I will share real-world examples of how good UX design has driven business results for iOS apps, including increased user engagement, higher conversion rates, and improved brand perception.\r\n\r\nI will also provide practical tips and strategies for incorporating UX design into your iOS development process, from conducting user research to designing intuitive user interfaces. Attendees will leave with a deeper understanding of the value of UX in iOS development, as well as actionable insights they can use to improve their own app design and development practices.", speakers: [Speaker.samples[0]], slidoURL: "https://app.sli.do/event/jHmthXSatH6w4BUEyjpDPa", videoURL: "https://www.youtube.com/watch?v=RZFeb5fD49s"),
    ]

    static let sample = samples[0]
}

extension Slot.Presentation.Speaker {
    static let samples = [
        Slot.Presentation.Speaker(id: UUID(), name: "Richie Flores", biography: "Hello World! I am a principal software engineer and iOS aficionado with a passion for designing impactful user experiences. With over 7 years of experience building software products, I have seen firsthand the difference that good UX design can make in driving business results. I believe that the key to creating successful software products lies in understanding the needs and pain points of users, and designing intuitive interfaces that make it easy for them to achieve their goals. Good UX design can make a difference in the AppStore by driving business results such as increased user engagement, higher conversion rates, and improved brand perception.", profileImage: "https://swiftleeds-speakers.s3.eu-west-2.amazonaws.com/7A6E0452-E3F3-4FE7-A645-88D8A6B3DFA6-richie-flores.jpg", organisation: "Northrop Grumman", twitter: "richiexflores")
    ]

    static let sample = samples[0]
}

fileprivate extension DateFormatter {
    static var iso: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
