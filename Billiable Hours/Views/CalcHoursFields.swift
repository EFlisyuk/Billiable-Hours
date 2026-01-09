//
//  CalcHoursFields.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 09.01.26.
//

import SwiftUI

struct CalcHoursFields: View {
    @Binding var vmh: HoursFieldsModel
    
    var body: some View {
        List{
            ForEach($vmh.result.indices, id: \.self) { i in
                HStack{
                    Text("\(vmh.resultStr[i])")
                        .padding(4)
                    Spacer()
                    Text("\(vmh.result[i], specifier: "%.4f") h")
                        .padding(4)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .listSectionSpacing(0)
        .listRowInsets(EdgeInsets())
    }
}

//#Preview {
//    CalcHoursFields()
//}
#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var vmh = HoursFieldsModel()

    var body: some View {
        CalcHoursFields(vmh: $vmh)
    }
}
