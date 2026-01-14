//
//  InputHoursFields.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 09.01.26.
//

import SwiftUI

struct InputHoursFields: View {
    @Binding var vmh: HoursFieldsModel
    
    var body: some View {
        VStack (spacing: 0) {
            Form {
                Section(header: Text("Duration (hh:mm:ss)")) {
                    HStack(spacing: 20) {
                        TextField ("00", text: $vmh.hoursStr)
                            .numberFieldBaseStyle()
                            .foregroundStyle(vmh.isValidHours(vmh.hoursStr) ? .blue : .red)
                        TextField ("00", text: $vmh.minutesStr)
                            .numberFieldBaseStyle()
                            .foregroundStyle(vmh.isValidMinutes(vmh.minutesStr) ? .blue : .red)
                        TextField ("00", text: $vmh.secondsStr)
                            .numberFieldBaseStyle()
                            .foregroundStyle(vmh.isValidSeconds(vmh.secondsStr) ? .blue : .red)
                        Spacer()
                        Button("Calc", systemImage: "arrow.right.circle")
                        {
                            vmh.submit()
                        }
                        .labelStyle(.iconOnly)
                        .disabled(!vmh.isValid)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .listRowBackground(Color.clear)
//                    HStack{
//                        Text("Validation \(vmh.isValid)")
//                            .font(.footnote)
//                    }
//                    .listRowBackground(Color.clear)
                }
                .listRowInsets(EdgeInsets())
            }
            .listSectionSpacing(0)
        }
    }
}


#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var vmh = HoursFieldsModel()

    var body: some View {
        InputHoursFields(vmh: $vmh)
    }
}
