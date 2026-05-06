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
    
    var body: some View {
        VStack {
            if calculations.isEmpty {
                ContentUnavailableView("No Calculations", systemImage: "numbers.rectangle")
                    .opacity(0.2)
            } else {
                
                List {
                    Section(header: Text("Hours")) {
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
                                    CopyButton(result: result, showCopied: $showCopied)
                                }
                                .foregroundStyle(.green)
                            }
                        }
                        .onDelete(perform: deleteCalc(indexes:))
                    }
                }
                .overlay(alignment: .top) {   // ✅ overlay НА List/контейнер, не внутри Button
                    if showCopied {
                        copiedBadge
                    }
                }
                .animation(.easeInOut, value: showCopied)
            }
        }
        .background(Color(.systemGroupedBackground))
        
        HStack {
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
            .buttonStyle(.borderless)
            .background(calculations.isEmpty ? Color.gray.opacity(0.3) : Color.red)
            .foregroundColor(.white)
            .cornerRadius(16)
            .padding(.horizontal)
            .disabled(calculations.isEmpty)
            .padding([.bottom, .top], 16)
        }
        .background(Color(.systemGroupedBackground))
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
}

#Preview {
    CalcHoursFields()
        .modelContainer(for: HoursFieldsModel.self, inMemory: true)
}
