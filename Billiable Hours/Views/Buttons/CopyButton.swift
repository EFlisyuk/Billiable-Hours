//
//  CopyButton.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 05.05.26.
//

import SwiftUI

struct CopyButton: View {
    let result: Double
    @Binding var showCopied: Bool
    
    var body: some View {
        Button {
            UIPasteboard.general.string = String(format: "%.3f", locale: Locale.current, result)
            showCopied = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                showCopied = false}
        }
        label: {
            Image(systemName: "square.on.square")
        }
        .buttonStyle(.borderless)
        .accessibilityLabel("Copy")
    }
}

#Preview {
    @Previewable @State var result: Double = 0
    @Previewable @State var showCopied: Bool = false
    CopyButton(result: result, showCopied: $showCopied)
        .modelContainer(for: [HoursFieldsModel.self, HoursList.self], inMemory: true)
}

