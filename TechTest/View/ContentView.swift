//
//  ContentView.swift
//  TechTest
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var dataStore = DataStore()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Divider()
                                
                ScheduleView(slots: dataStore.slots)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .opacity(dataStore.isUpdating ? 1 : 0)
                }
            }
            .navigationTitle("SwiftLeeds")
            .task {
                try? await dataStore.update()
            }
        }
    }
}

#Preview {
    ContentView()
}
