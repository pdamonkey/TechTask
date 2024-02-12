//
//  ScheduleView.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import SwiftUI
import API

struct ScheduleView: View {
    let slots: [Slot]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0){
                ForEach(slots) { slot in
                    NavigationLink {
                        SlotDetailsView(slot: slot)
                    } label: {
                        SlotView(slot: slot)
                    }
                }
            }
        }
    }
}

#Preview {
    ScheduleView(slots: Slot.samples)
        .padding()
}
