//
//  ListDetail.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 11/05/2026.
//

import SwiftUI
import SwiftData

struct ListDetail: View {
    @Environment(\.modelContext) private var context
    let calculations: HoursList
    @State private var showCopied = false
    @State var selectedMode: ViewMode = .hours
    
    var body: some View {
        VStack {
            Picker("Mode", selection: $selectedMode) {
                Text("Hours").tag(ViewMode.hours)
                Text("Earnings").tag(ViewMode.earnings)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.top, 16)
            
            if selectedMode == .hours {
                
                calculatedHoursList
                
            } else {
                
                calculatedEarningsList
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("\(calculations.name)")
        .contentMargins(.top, 8)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(item: csvURL())
            }
        }
        .overlay(alignment: .top) {  
            if showCopied {
                copiedBadge
            }
        }
        .animation(.easeInOut, value: showCopied)
    }
    
    private var calculatedHoursList: some View {
        VStack {
            Form {
                HStack {
                    Text("\(calculations.sumDurations)")
                    Spacer()
                    Text("\(calculations.sumHours)")
                    CopyButton(result: calculations.sumHours, showCopied: $showCopied)
                }
                .foregroundStyle(.primary)
                
                ForEach(calculations.listResults) { row in
                    HStack {
                        HStack {
                            Image(systemName: "clock")
                            Text("\(row.resultString)")
                        }
                        .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "h.circle")
                            Text("\(row.resultDigit, specifier: "%.3f")")
                            CopyButton(result: row.resultDigit, showCopied: $showCopied)
                        }
                        .foregroundStyle(.green)
                    }
                }
            }
        }
    }
    
    private var calculatedEarningsList: some View {
        Form {
            HStack {
                Text("Hourly rate")
                Spacer()
                Text("\(calculations.hourlyRate)")
            }
            
            ForEach(calculations.listResults) { row in
                HStack {
                    HStack {
                        Image(systemName: "h.circle")
                        Text("\(row.resultDigit, specifier: "%.3f")")
                    }
                    .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        
                        if let rate = Double(calculations.hourlyRate) {
                            Text("\(row.resultDigit * rate, specifier: "%.3f")")
                        } else {
                            Text("")
                        }
                    }
                    .foregroundStyle(.green)
                }
            }
        }
    }
    
    private var copiedBadge: some View {
        Text("Copied")
            .font(.subheadline)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(.white)
            .clipShape(Capsule())
            .padding(.top, 12)
            .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    func exportCSV() -> String {
        let rate = Double(calculations.hourlyRate) ?? 0
        var csv = "Duration;Hours;Earnings\n"
        for row in calculations.listResults {
            let earnings = rate > 0 ? String(format: "%.2f", locale: Locale.current, row.resultDigit * rate) : ""
            csv += "\(row.resultString);\(String(format: "%.3f", locale: Locale.current, row.resultDigit));\(earnings)\n"
        }
        return csv
    }
    
    func csvURL() -> URL {
        let csv = exportCSV()
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("\(calculations.name).csv")
        try? csv.write(to: url, atomically: true, encoding: .utf8)
        return url
    }
}

