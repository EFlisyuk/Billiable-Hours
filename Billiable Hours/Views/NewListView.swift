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

    var body: some View {
        Form {
            TextField("New List Name", text: $newHoursListName)
                .textSelectionAffinity(.upstream)

            Section("Hours List") {
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
                    let simpleItems = calculations.map {
                        ArchivedCalculation(
                            resultDigit: $0.resultDigit,
                            resultString: $0.resultString,
                            date: $0.date, id: UUID()
                        )
                    }

                    // 2. Создаем архивный список с этими данными
                    let newList = HoursList(name: newHoursListName, listResults: simpleItems, date: .now)
                    context.insert(newList)

                    // 3. Теперь удаляем оригиналы.
                    // Поскольку в newList лежат простые структуры, а не ссылки на классы,
                    // удаление calculations их никак не заденет!
                    for original in calculations {
                        context.delete(original)
                    }

                    do {
                        try context.save()
                        dismiss()
                    } catch {
                        print("Ошибка: \(error)")
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
}

#Preview {
    NewListView()
        .modelContainer(for: [HoursFieldsModel.self, HoursList.self], inMemory: true)
}
