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
                Section(header: Text("Add worked hours")) {
                    HStack(spacing: 20) {
                        TextField ("00", text: $vmh.hoursStr)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                    
                                )
                            .keyboardType(.numberPad)
                           
                            
//                            .foregroundStyle(vm.isValid ? .blue : .red)
//                            .id(vm.isValid)
                        TextField ("00", text: $vmh.minutesStr)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                    
                                )
//                            .frame(width: 60)
                            .keyboardType(.numberPad)
//                            .foregroundStyle(vm.isValid ? .blue : .red)
//                            .id(vm.isValid)
                        TextField ("00", text: $vmh.secondsStr)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                    
                                )
//                            .frame(width: 60)
                            .keyboardType(.numberPad)
//                            .foregroundStyle(vm.isValid ? .blue : .red)
//                            .id(vm.isValid)

                        Spacer()
                        Button("Calc", systemImage: "arrow.right.circle") /*{*/
                        {
                            vmh.submit()
                        }
                        .labelStyle(.iconOnly)
//                        .disabled(!vm.isValid)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .listRowBackground(Color.clear)
//                    HStack{
//                        Text("Validation \(vm.isValid)")
//                            .font(.footnote)
//                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .listSectionSpacing(0)
            
        }
    }
}

//#Preview {
//    InputHoursFields(vmh: HoursFieldsModel())
//}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var vmh = HoursFieldsModel()

    var body: some View {
        InputHoursFields(vmh: $vmh)
    }
}
