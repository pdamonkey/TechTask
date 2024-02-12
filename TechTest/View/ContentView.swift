//
//  ContentView.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(DataStore.self) private var dataStore
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                scheduleDates
                
                Divider()
                                
                if let selectedDate = dataStore.selectedDate, let slots = dataStore.slots[selectedDate] {
                    ScheduleView(slots: slots)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .opacity(dataStore.isUpdating ? 1 : 0)
                }
            }
            .navigationTitle("SwiftLeeds")
        }
    }
    
    var scheduleDates: some View {
        HStack(spacing: 16) {
            ForEach(dataStore.dates, id: \.self) { date in
                VStack {
                    Button(action: {
                        dataStore.selectedDate = date
                    }, label: {
                        Text(date.formatted(.dateTime.day().month()))
                            .overlay(alignment: .bottom) {
                                Rectangle()
                                    .frame(height: 2)
                                    .offset(y: 2)
                                    .opacity(date == dataStore.selectedDate ? 1 : 0)
                            }
                    })
                }
            }
        }
        .foregroundStyle(.text)
        .padding(.bottom)
    }
}

#Preview {
    ContentView()
}
