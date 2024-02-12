//
//  Slot+Helper.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import Foundation
import API

extension Slot {
    /// The start time for the slot in short time format.
    var startTime: String {
        DateFormatter.timeDateFormatter.string(from: date)
    }

    /// The end time for the ``Slot`` in short time format.
    var endTime: String {
        let endDate = date.addingTimeInterval(TimeInterval(duration * 60))
        return DateFormatter.timeDateFormatter.string(from: endDate)
    }

    /// The title of the ``Slot``, retrieved from the Activity or Presentation.
    var title: String {
        activity?.title ?? presentation?.title ?? ""
    }
    
    /// The subtitle of the ``Slot``, either the ``Activity`` subtitle, or a list of ``Speaker``s and Organisations if a ``Presentation``.
    var subtitle: String? {
        guard let speakers = presentation?.speakers else { return activity?.subtitle }

        let formattedSpeakers = ListFormatter.localizedString(byJoining: speakers.map { $0.name })
        let organisations = Array(Set(speakers.compactMap { $0.organisation }))
        let formattedOrganisations = ListFormatter.localizedString(byJoining: organisations)
        return "\(formattedSpeakers) (\(formattedOrganisations))"
    }

    /// The details of the ``Slot``, either the ``Activity`` description or the ``Presentation`` synopsis.
    var details: String {
        activity?.description ?? presentation?.synopsis ?? ""
    }

    /// The accessiblity label of the slot containing start and end times, title and subtitle.
    var accessibilityLabel: String {
        "\(startTime) till \(endTime). \(title). \(subtitle ?? "")"
    }

    /// The type of ``Slot``, either an ``Activity`` or ``Presentation``, but if neither then will be classed as `.unknown`
    var type: SlotType {
        if activity != nil { return .activity}
        if presentation != nil { return .presentation}
        return .unknown
    }

    // MARK: - SlotType
    enum SlotType: String {
        case activity, presentation, unknown
    }
}

// MARK: - Time DateFormatter
fileprivate extension DateFormatter {
    // Used for formatting start and end times
    static var timeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
