//
//  CalcButton.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 05.05.26.
//

import SwiftUI
import SwiftData

struct CalcButton: View {
    @Bindable var vmh: HoursFieldsModel
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Button("Calc", systemImage: "arrow.right")
        {
            // create new object
            let newCalculation = HoursFieldsModel(
                hoursStr: vmh.hoursStr,
                minutesStr: vmh.minutesStr,
                secondsStr: vmh.secondsStr
            )
            
            // results for new object
            newCalculation.submit()
            
            // add new odject in context
            context.insert(newCalculation)
            
            do {
                try context.save()
            } catch {
                print("Save error: \(error.localizedDescription)")
            }

            vmh.hoursStr = ""
            vmh.minutesStr = ""
            vmh.secondsStr = ""
        }
        .labelStyle(.iconOnly)
        .fixedSize(horizontal: true, vertical: false)
        .buttonStyle(.borderless)
        .disabled(!vmh.isValid)
        .opacity(vmh.isValid ? 1 : 0.35)
        .padding(.vertical, 8)
        .padding(.horizontal, 28)
        .background(.blue)
        .foregroundColor(.white)
        .cornerRadius(12)
    }
}

#Preview {
    @Previewable @State var vmh = HoursFieldsModel()
    CalcButton(vmh: vmh)
        .modelContainer(for: [HoursFieldsModel.self, HoursList.self], inMemory: true)
}
