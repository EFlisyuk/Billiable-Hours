//
//  CalcHoursFields.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 09.01.26.
//

import SwiftUI
import SwiftData

struct CalcHoursFields: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \HoursFieldsModel.date) var calculations: [HoursFieldsModel]
    @State private var showCopied = false
    @State private var showModal = false
    @State var selectedMode: ViewMode = .hours
    @State private var hourlyRate: String = ""

    var body: some View {
        VStack {
            if calculations.isEmpty {
                ContentUnavailableView("No Calculations", systemImage: "numbers.rectangle")
                    .opacity(0.2)
                    .background(Color(.systemGroupedBackground))
            } else {
                VStack {
                    Picker("Mode", selection: $selectedMode) {
                        Text("Hours").tag(ViewMode.hours)
                        Text("Earnings").tag(ViewMode.earnings)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    .padding(.top, 16)

                    if selectedMode == .hours {

                        calculatedHoursList

                    } else {

                        calculatedEarningsList
                    }
                }
                .background(Color(.systemGroupedBackground))

            }
        }

        buttonsListControl

    }

    private var calculatedHoursList: some View {
        List {
            HStack {
                Text("\(sumDurations)")
                Spacer()
                Text("\(sumHours, specifier: "%.3f")")
                CopyButton(result: sumHours, showCopied: $showCopied)
            }
            .foregroundStyle(.primary)

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
                        CopyButton(result: result.resultDigit, showCopied: $showCopied)
                    }
                    .foregroundStyle(.green)
                }
            }
            .onDelete(perform: deleteCalc(indexes:))
        }
        .overlay(alignment: .top) {   // ✅ overlay НА List/контейнер, не внутри Button
            if showCopied {
                copiedBadge
            }
        }
        .animation(.easeInOut, value: showCopied)
    }

    private var calculatedEarningsList: some View {

        List {
            HStack {
                Text("Hourly Rate")
                Spacer()
                TextField("0.0", text: $hourlyRate)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing)
                    .foregroundStyle(.blue)
            }

            ForEach(calculations) { result in
                HStack {
                    HStack {
                        Image(systemName: "h.circle")
                        Text("\(result.resultDigit, specifier: "%.3f")")
                    }
                    .foregroundStyle(.green)

                    Spacer()

                    HStack {
                        Image(systemName: "dollarsign.circle")
                        if let rate = Double(hourlyRate) {
                            Text("\(result.resultDigit * rate, specifier: "%.2f")")
                        } else {
                            Text("")
                        }
                    }
                }
            }
            .onDelete(perform: deleteCalc(indexes:))
        }
    }

    private var buttonsListControl: some View {

        HStack (spacing: 16) {
            Button(role: .destructive) {
                for row in calculations {
                    context.delete(row)
                    do {
                        try context.save()
                    }
                    catch {
                        print("Ошибка при очистке базы: \(error)")
                    }
                }
            } label: {
                Label("Clean list", systemImage: "trash")
                    .frame(maxWidth: .infinity)        // ← на всю ширину
                    .padding(.vertical, 14)            // ← большая высота
                    .contentShape(Rectangle())         // ← вся площадь кликабельна
            }
            .buttonsListControlStyle(isEmpty: calculations.isEmpty , color: .red)

            Button {
                showModal = true
            } label: {
                Label("Save list", systemImage: "plus.square")
                    .frame(maxWidth: .infinity)        // ← на всю ширину
                    .padding(.vertical, 14)            // ← большая высота
                    .contentShape(Rectangle())         // ← вся площадь кликабельна
            }
            .buttonsListControlStyle(isEmpty: calculations.isEmpty , color: .green)
        }
        .padding()
        .padding(.bottom, 16)
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $showModal) {
            NavigationStack {
                NewListView(hourlyRate: hourlyRate)
            }
        }
    }


    func deleteCalc(indexes: IndexSet) {
        for index in indexes {
            let calcToDelete = calculations[index]
            context.delete(calcToDelete)
        }
    }

    private var copiedBadge: some View {
        Text("Copied")
            .font(.subheadline)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(.white)
            .clipShape(Capsule())
            .padding(.top, 12)
            .transition(.move(edge: .top).combined(with: .opacity))
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
    CalcHoursFields()
        .modelContainer(for: [HoursFieldsModel.self, HoursList.self], inMemory: true)
}


#Preview("Test Data") {
    CalcHoursFields()
        .modelContainer(previewContainer())
}

