//
//  SlotView.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import SwiftUI
import API

struct SlotView: View {
    let slot: Slot
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack {
                startTime
                endTime
            }
            .frame(width: 40)
            .padding(.bottom)
            
            timelineIndicator
            
            VStack(alignment: .leading) {
                title
                subtitle
            }

            Spacer()
        }
        .foregroundStyle(.text)
        .padding(.top)
        .padding(.horizontal)
        .clipShape(.rect)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(slot.accessibilityLabel)
        .accessibilityIdentifier(slot.id.uuidString)
    }
    
    private var startTime: some View {
        Text(slot.startTime)
            .font(.caption.weight(.medium))
            .dynamicTypeSize(...DynamicTypeSize.accessibility2)
            .padding(.bottom, 2)
    }
    
    private var endTime: some View {
        Text(slot.endTime)
            .font(.caption2.weight(.thin))
            .dynamicTypeSize(...DynamicTypeSize.accessibility2)
    }
    
    private var timelineIndicator: some View {
        VStack {
            Circle()
                .fill(slot.type == .activity ? .green : .blue)
                .frame(width: 10, height: 10)
        }
        .background {
            // Timeline line
            Rectangle()
                .fill(.gray)
                .frame(width: 0.5)
                .frame(height: 500)
        }
    }
    
    private var title: some View {
        Text(slot.title)
            .font(.body.weight(.medium))
            .multilineTextAlignment(.leading)
    }
    
    @ViewBuilder
    private var subtitle: some View {
        if let subtitle = slot.subtitle {
            HStack {
                if let photoURL = slot.presentation?.speakers.first?.profileImage, let url = URL(string: photoURL) {
                    CachedAsyncImage(url: url)
                        .frame(width: 30, height: 30)
                        .clipShape(.circle)
                        .overlay {
                            Circle()
                                .stroke(.gray)
                        }
                }

                Text(subtitle)
                    .font(.body.weight(.thin))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    VStack(spacing: 0) {
        SlotView(slot: Slot.samples[0])
        SlotView(slot: Slot.samples[1])
        SlotView(slot: Slot.samples[2])
    }
    .padding()
}
