//
//  ConvertedHoursRow.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 02.01.26.
//

import SwiftUI

struct InputHoursRow: View {
    
    //    @State private var vm = HoursToBill()
    @Binding var vm: HoursToBill
    //    @State var result: [Double] = []
    
    var body: some View {
        VStack (spacing: 0) {
            Form {
                Section(header: Text("Add worked hours")) {
                    HStack {
                        TextField ("Hours : minutes : seconds", text: $vm.inputStr)
                            .keyboardType(.numberPad)
                            .foregroundStyle(vm.isValid ? .blue : .red)
                            .id(vm.isValid)
                        
                        Text("Validation \(vm.isValid)")
                        Spacer()
                        Button("Calc", systemImage: "arrow.right.circle") /*{*/
                        {
                            vm.submit()
                        }
                        .disabled(!vm.isValid)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                }
            }
        }
    }
}
        
    
//#Preview {
//    InputHoursRow(vm: HoursToBill())
//}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var vm = HoursToBill()

    var body: some View {
        InputHoursRow(vm: $vm)
    }
}
