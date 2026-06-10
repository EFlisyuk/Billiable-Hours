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
                NavigationStack {
                    ListsView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [HoursFieldsModel.self, HoursList.self], inMemory: true)
}

#Preview("Dark") {
    ContentView()
        .modelContainer(for: [HoursFieldsModel.self, HoursList.self], inMemory: true)
        .preferredColorScheme(.dark)
}
