//
//  Slot.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import Foundation

struct Slot: Decodable {
    let id: UUID
    let date: Date
    let duration: Int
    let activity: Activity?
    let presentation: Presentation?

    struct Activity: Decodable {
        let id: UUID
        let title: String
        let subtitle: String
        let description: String
        let image: String
        let metadataURL: String?
    }

    struct Presentation: Decodable {
        let id: UUID
        let title: String
        let synopsis: String
        let speakers: [Speaker]
        let slidoURL: String?
        let videoURL: String?

        struct Speaker: Decodable {
            let id: UUID
            let name: String
            let biography: String
            let profileImage: String
            let organisation: String?
            let twitter: String?
        }
    }
}
