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
                Section {
                    HStack(spacing: 10) {
                        TextField ("00", text: $vmh.hoursStr)
                            .numberFieldBaseStyle()
                            .foregroundStyle(vmh.isValidHours(vmh.hoursStr) ? .blue : .red)
                        Text(":")
                            .foregroundStyle(.secondary)
                        TextField ("00", text: $vmh.minutesStr)
                            .numberFieldBaseStyle()
                            .foregroundStyle(vmh.isValidMinutes(vmh.minutesStr) ? .blue : .red)
                        Text(":")
                            .foregroundStyle(.secondary)
                        TextField ("00", text: $vmh.secondsStr)
                            .numberFieldBaseStyle()
                            .foregroundStyle(vmh.isValidSeconds(vmh.secondsStr) ? .blue : .red)
                        Spacer()
                        Button("Calc", systemImage: "arrow.right.circle")
                        {
                            vmh.submit()
                        }
                        .labelStyle(.titleAndIcon)
                        .fixedSize(horizontal: true, vertical: false)
                        .buttonStyle(.borderless)
                        .disabled(!vmh.isValid)
                        .opacity(vmh.isValid ? 1 : 0.35) 
                        .padding(.vertical, 5)
                        .padding(.horizontal, 12)
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
                header: {
                    Text("Duration (hh:mm:ss)")
                        .padding(.horizontal, 20)
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
