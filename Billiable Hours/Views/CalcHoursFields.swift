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
        List{
            ForEach($vmh.result.indices, id: \.self) { i in
                HStack{
                    Text("\(vmh.resultStr[i])")
                        .padding(4)
                    Spacer()
                    Text("\(vmh.result[i], specifier: "%.3f") h")
                        .padding(4)
                        .foregroundStyle(.secondary)
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
