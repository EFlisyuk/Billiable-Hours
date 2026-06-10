//
//  ListDetail.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 11/05/2026.
//

import SwiftUI
import SwiftData

struct ListDetail: View {
    @Environment(\.modelContext) private var context
    let calculations: HoursList
    @State private var showCopied = false

    var body: some View {
        Form {
            ForEach(calculations.listResults) { row in
                HStack {
                    HStack {
                        Image(systemName: "clock")
                        Text("\(row.resultString)")
                    }
                    .foregroundStyle(.secondary)

                    Spacer()

                    HStack {
                        Image(systemName: "h.circle")
                        Text("\(row.resultDigit, specifier: "%.3f")")
                        CopyButton(result: row.resultDigit, showCopied: $showCopied)
                    }
                    .foregroundStyle(.green)
                }
            }
        }
        .navigationTitle("\(calculations.name)")
        .overlay(alignment: .top) {   // ✅ overlay НА List/контейнер, не внутри Button
            if showCopied {
                copiedBadge
            }
        }
        .animation(.easeInOut, value: showCopied)
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

//#Preview {
//    ListDetail()
//        .modelContainer(for: [HoursFieldsModel.self, HoursList.self], inMemory: true)
//}
