//
//  ViewMode.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 08/07/2026.
//

enum ViewMode: String, CaseIterable, Identifiable {
    case hours, earnings
    var id: String { self.rawValue }
}
