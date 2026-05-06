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
        Button("Calc", systemImage: "arrow.right.circle")
        {
            let newCalculation = HoursFieldsModel(
                hoursStr: vmh.hoursStr,
                minutesStr: vmh.minutesStr,
                secondsStr: vmh.secondsStr
            )
            
            // 2. Считаем результат для этого нового объекта
            newCalculation.submit()
            
            // 3. Вот теперь вставляем НОВЫЙ объект
            context.insert(newCalculation)
            
            do {
                try context.save()
                print("Часы \(newCalculation.hoursStr)")
                print("Резалт \(newCalculation.resultDigit)")
            } catch {
                print("Ошибка сохранения: \(error.localizedDescription)")
            }
            
            // 4. Очищаем поля ввода (черновика), если нужно
            vmh.hoursStr = ""
            vmh.minutesStr = ""
            vmh.secondsStr = ""
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
}

#Preview {
    @Previewable @State var vmh = HoursFieldsModel()
    CalcButton(vmh: vmh)
        .modelContainer(for: HoursFieldsModel.self, inMemory: true)
}
