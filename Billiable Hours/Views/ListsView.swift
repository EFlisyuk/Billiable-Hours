//
//  ListsView.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 06.05.26.
//

import SwiftUI
import SwiftData

struct ListsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \HoursList.date) var hoursList: [HoursList]

    var body: some View {
        if hoursList.isEmpty {
            ContentUnavailableView("Saved Lists", systemImage: "list.star")
                .opacity(0.2)
        } else {
            Form {
                ForEach(hoursList) { row in
                    NavigationLink("\(row.name)", destination: ListDetail(calculations: row))
                }

            }
            .navigationTitle("Lists")
            .contentMargins(.top, 8)
        }
    }
}

#Preview {
    ListsView()
        .modelContainer(for: [HoursFieldsModel.self, HoursList.self], inMemory: true)
}
