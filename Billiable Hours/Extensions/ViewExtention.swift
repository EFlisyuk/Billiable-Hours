//
//  ViewExtention.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 14.08.2026.
//

import SwiftUI
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
