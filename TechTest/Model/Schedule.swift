//
//  Schedule.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import Foundation

struct Schedule: Decodable {
    let data: Data

    struct Data: Decodable {
        let slots: [Slot]
    }
}
