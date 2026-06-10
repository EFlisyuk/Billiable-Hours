//
//  List.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 06.05.26.
//

import Foundation
import SwiftData

@Model
class HoursList {
    var name: String
    var listResults: [ArchivedCalculation]
    var date: Date
    
    init(name: String, listResults: [ArchivedCalculation], date: Date = .now) {
        self.name = name
        self.listResults = listResults
        self.date = date
    }
}

struct ArchivedCalculation: Identifiable, Codable {
    let resultDigit: Double
    let resultString: String
    let date: Date
    let id: UUID
}
