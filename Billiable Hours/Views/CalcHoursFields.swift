//
//  CalcHoursFields.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 09.01.26.
//

import SwiftUI

struct CalcHoursFields: View {
    @Binding var vmh: HoursFieldsModel
    @State private var showConfirmationDialog = false
    @State private var deleteIndex: Int? = nil
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Hours")) {
                    ForEach($vmh.result.indices, id: \.self) { i in
                        HStack{
                            HStack{
                                Image(systemName: "clock")
                                Text("\(vmh.resultStr[i])")
                            }
                            .foregroundStyle(.secondary)
                            Spacer()
                            HStack{
                                Text("\(vmh.result[i], specifier: "%.3f")")
                                Image(systemName: "h.circle")
                            }
                            .foregroundStyle(.green)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteIndex = i
                                showConfirmationDialog = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .listSectionSpacing(0)
            .listRowInsets(EdgeInsets())
            .confirmationDialog("Are you sure you want to delete this comment?", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    if let idx = deleteIndex {
                        vmh.delete(at: idx)
                    }
                    deleteIndex = nil
                }
                Button("Cancel", role: .cancel) {
                    deleteIndex = nil
                }
            }
            HStack{
                Button(role: .destructive) {
                    vmh.result = []
                    vmh.resultStr = []
                } label: {
                    Label("Clean list", systemImage: "trash")
                        .frame(maxWidth: .infinity)        // ← на всю ширину
                        .padding(.vertical, 14)            // ← большая высота
                        .contentShape(Rectangle())         // ← вся площадь кликабельна
                }
                .buttonStyle(.borderless)
                .background(vmh.result.isEmpty ? Color.gray.opacity(0.3) : Color.red)
                .foregroundColor(.white)
                .cornerRadius(16)
                .padding(.horizontal)
                .disabled(vmh.result.isEmpty)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var vmh = HoursFieldsModel()

    var body: some View {
        CalcHoursFields(vmh: $vmh)
    }
}
