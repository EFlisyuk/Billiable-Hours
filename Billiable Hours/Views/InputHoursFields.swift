//
//  InputHoursFields.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 09.01.26.
//

import SwiftUI
import SwiftData

struct InputHoursFields: View {
    @Bindable var vmh: HoursFieldsModel
    @Environment(\.modelContext) private var context
    @Query var calculations: [HoursFieldsModel]
    
    var body: some View {
        VStack (spacing: 0) {
            Form {
                Section {
                    HStack(spacing: 10) {
                        
                        TextField ("00", text: $vmh.hoursStr)
                            .numberFieldBaseStyle()
                            .foregroundStyle(vmh.isValidHours(vmh.hoursStr) ? .blue : .red)
                        
                        Text(":")
                            .foregroundStyle(.secondary)
                        
                        TextField ("00", text: $vmh.minutesStr)
                            .numberFieldBaseStyle()
                            .foregroundStyle(vmh.isValidMinutes(vmh.minutesStr) ? .blue : .red)
                        
                        Text(":")
                            .foregroundStyle(.secondary)
                        
                        TextField ("00", text: $vmh.secondsStr)
                            .numberFieldBaseStyle()
                            .foregroundStyle(vmh.isValidSeconds(vmh.secondsStr) ? .blue : .red)
                        
                        Spacer()
                        
                        CalcButton(vmh: vmh)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    //                    HStack {
                    //                        Text("Validation \(vmh.isValid)")
                    //                            .font(.footnote)
                    //                    }
                    //                    .listRowBackground(Color.clear)
                }
                header: {
                    Text("Duration (hh:mm:ss)")
                        .padding(.horizontal, 20)
                }
                .listRowInsets(EdgeInsets())
            }
        }
    }
}

