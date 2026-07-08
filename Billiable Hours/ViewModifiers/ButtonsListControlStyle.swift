//
//  ButtonsListControlStyle.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 08/07/2026.
//

import SwiftUI

struct ButtonsListControlStyle: ViewModifier {
    let isEmpty: Bool
    let color: Color

    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderless)
            .foregroundColor(.white)
            .background(isEmpty ? Color.gray.opacity(0.3) : color)
            .cornerRadius(36)
            .disabled(isEmpty)
    }
}

extension View {
    func buttonsListControlStyle(isEmpty: Bool, color: Color) -> some View {
        self.modifier(ButtonsListControlStyle(isEmpty: isEmpty, color: color))
    }
}

