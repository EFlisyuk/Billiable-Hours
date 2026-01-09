//
//  ConvertedHoursRow.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 02.01.26.
//

import SwiftUI

struct ConvertedHoursRow: View {
    @Binding var vm: HoursToBill
    
    var body: some View {
        List{
            ForEach($vm.result.indices, id: \.self) { i in
                HStack{
                    Text("\(vm.result[i], specifier: "%.4f") h")
                        .padding(4)
                    Spacer()
                    Text("\(vm.result[i], specifier: "%.4f") h")
                        .padding(4)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

//#Preview {
//    ConvertedHoursRow(vm: $vm)
//}
#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var vm = HoursToBill()

    var body: some View {
        ConvertedHoursRow(vm: $vm)
    }
}
