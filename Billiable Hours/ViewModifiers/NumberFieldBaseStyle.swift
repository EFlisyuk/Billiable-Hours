//
//  NumberFieldBaseStyle.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 14.01.26.
//

import SwiftUI

struct NumberFieldBaseStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .padding(.vertical, 4)
            .padding(.horizontal, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.secondarySystemGroupedBackground))
            )
            .keyboardType(.numberPad)
    }
}

extension View {
    func numberFieldBaseStyle() -> some View {
        self.modifier(NumberFieldBaseStyle())
    }
}

