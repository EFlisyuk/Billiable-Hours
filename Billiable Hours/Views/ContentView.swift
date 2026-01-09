//
//  ContentView.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 16.09.25.
//

import SwiftUI



struct ContentView: View {
//  var total = calculate(51, 37, 14)
//  var totalHours = calculateHours(00, 22, 56)
//    @Binding var inputHours: String
//    var album:
    @State private var vm = HoursToBill()
    @State private var vmh = HoursFieldsModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 0)  {
                    InputHoursFields(vmh: $vmh)
                        .frame(height: 100)
//                        .padding(0)
                    CalcHoursFields(vmh: $vmh)
//                        .padding(0)
                }
            }
            .navigationTitle("Worked Time")
            .padding(0)
        }
        
    }
}

#Preview {
    ContentView()
}
