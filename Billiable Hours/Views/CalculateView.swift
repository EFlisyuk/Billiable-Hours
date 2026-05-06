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
                    CalcHoursFields()
                }
            }
            .navigationTitle("Worked Time")
            .padding(0)
        }
    }
}

#Preview {
    CalculateView()
        .modelContainer(for: HoursFieldsModel.self, inMemory: true)
}
