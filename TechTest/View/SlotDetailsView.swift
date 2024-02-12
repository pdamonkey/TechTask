//
//  SlotDetailsView.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import SwiftUI
import API

struct SlotDetailsView: View {
    let slot: Slot
    
    var body: some View {
        VStack {
            if let photoURL = slot.activity?.image, let url = URL(string: photoURL) {
                // If an Activity image, take up the whole width
                CachedAsyncImage(url: url)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 150)
            } else if let photoURL = slot.presentation?.speakers.first?.profileImage, let url = URL(string: photoURL) {
                // If a Speaker image, show in Circle Avatar style
                CachedAsyncImage(url: url)
                    .frame(width: 150, height: 150)
                    .clipShape(.circle)
                    .background {
                        Circle()
                            .stroke(.gray)
                    }
            }

            ScrollView {
                Text(slot.title)
                    .font(.title)
                    .multilineTextAlignment(.center)

                if let subtitle = slot.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }

                Text(slot.details)
                    .font(.body.weight(.thin))
                    .padding(.top)

                Spacer()
            }
            .scrollBounceBehavior(.basedOnSize)
            .padding()
        }
        .foregroundStyle(.text)
    }
}

#Preview {
    SlotDetailsView(slot: .sampleActivity)
}
