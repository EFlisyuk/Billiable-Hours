//
//  CalculateView.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 04.05.26.
//

import SwiftUI
import SwiftData

struct CalculateView: View {
    @State private var vmh = HoursFieldsModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    InputHoursFields(vmh: vmh)
                        .frame(height: 100)
                        .scrollDisabled(true) // 1. Запрещаем форме скроллиться внутри себя
                        
                    //                            .fixedSize(horizontal: false, vertical: true) // 2. Магия! Говорит форме: "Займи по вертикали только свой идеальный размер"
                   
                    CalcHoursFields()

                }
            }
            .navigationTitle("Worked Time")
            .contentMargins(.top, 8)
            .padding(0)
        }
    }
}

#Preview {
    CalculateView()
        .modelContainer(for: [HoursFieldsModel.self, HoursList.self], inMemory: true)
}
