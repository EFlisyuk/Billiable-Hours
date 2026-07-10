//
//  NewListView.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 06.05.26.
//

import SwiftUI
import SwiftData

struct NewListView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \HoursFieldsModel.date) var calculations: [HoursFieldsModel]
    @State private var newHoursListName: String = "New List Name"
    var hourlyRate: String

    var body: some View {
        Form {
            TextField("New List Name", text: $newHoursListName)
                .textSelectionAffinity(.upstream)

            Section("Hours List") {
                HStack {
                    Text("Hourly Rate: ")
                    Spacer()
                    Text("\(hourlyRate)")
                }

                HStack {
                    Image(systemName: "clock")
                    Text("\(sumDurations)")
                    Spacer()
                    Image(systemName: "h.circle")
                    Text("\(sumHours)")
                }

                ForEach(calculations) { result in
                    HStack {
                        HStack {
                            Image(systemName: "clock")
                            Text("\(result.resultString)")
                        }
                        .foregroundStyle(.secondary)

                        Spacer()

                        HStack {
                            Image(systemName: "h.circle")
                            Text("\(result.resultDigit, specifier: "%.3f")")
                        }
                        .foregroundStyle(.green)
                    }
                }
            }
        }
        .navigationTitle("Save list")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    // create a snapshot of each calculation
                    let simpleItems = calculations.map {
                        ArchivedCalculation(
                            resultDigit: $0.resultDigit,
                            resultString: $0.resultString,
                            date: $0.date, id: UUID()
                        )
                    }

                    // create archive list with a structure instead link on class
                    let newList = HoursList(name: newHoursListName, sumHours: sumHours, sumDurations: sumDurations, hourlyRate: hourlyRate, listResults: simpleItems, date: .now)
                    context.insert(newList)

                    // delete originals from the working queue
                    for original in calculations {
                        context.delete(original)
                    }

                    do {
                        try context.save()
                        dismiss()
                    } catch {
                        print("Save error: \(error)")
                    }
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }

    private var sumHours: Double {
        calculations.reduce(0) {$0 + $1.resultDigit}
    }

    private var sumDurations: String {
        let sumResultDigit = calculations.reduce(0) { $0 + $1.resultDigit }

        let h = Int(sumResultDigit)
        let m = Int((sumResultDigit * 60).truncatingRemainder(dividingBy: 60))
        let s = Int((sumResultDigit * 3600).truncatingRemainder(dividingBy: 60))

        return String(format: "%d:%02d:%02d", h, m, s)
    }
}

#Preview {
    @Previewable @State var hourlyRate: String = "0.0"
    NewListView(hourlyRate: hourlyRate)
        .modelContainer(for: [HoursFieldsModel.self, HoursList.self], inMemory: true)
}
