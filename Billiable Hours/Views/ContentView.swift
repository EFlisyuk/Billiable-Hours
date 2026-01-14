//
//  ContentView.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 16.09.25.
//

import SwiftUI



struct ContentView: View {
    @State private var vmh = HoursFieldsModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 0)  {
                    InputHoursFields(vmh: $vmh)
                        .frame(height: 100)
                    CalcHoursFields(vmh: $vmh)
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
