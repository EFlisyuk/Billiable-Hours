//
//  ContentView.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 16.09.25.
//

import SwiftUI

func calculate(_ hours: Int, _ minutes: Double, _ seconds: Double) -> Double {
    let hoursMinutes = Double(minutes/60)
    let totalHours: Double = Double(hours) + Double (minutes/60) + Double(seconds/3600)
    return totalHours * 1400
}

func calculateHours(_ hours: Int, _ minutes: Double, _ seconds: Double) -> Double {
    let hoursMinutes = Double(minutes/60)
    let totalHours: Double = Double(hours) + Double (minutes/60) + Double(seconds/3600)
    return totalHours
}
 
struct ContentView: View {
  var total = calculate(51, 37, 14)
  var totalHours = calculateHours(00, 22, 56)
   
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "hands.and.sparkles")
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.green)
            Spacer()
            Text("Привет! Ты отлично поработала в прошлом месяце!")
                .font(.title)
            Spacer()
//            Text("Total: \(total)")
//                .font(.largeTitle)
            Text("Hours: \(totalHours)")
                .font(.largeTitle)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
