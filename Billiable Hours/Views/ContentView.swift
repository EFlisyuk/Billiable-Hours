//
//  ContentView.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 16.09.25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("Calculate", systemImage: "numbers.rectangle") {
                CalculateView()
            }
            
            Tab("Lists", systemImage: "list.star") {
                ContentUnavailableView("Saved Lists", systemImage: "list.star")
                    .opacity(0.2)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: HoursFieldsModel.self, inMemory: true)
}
