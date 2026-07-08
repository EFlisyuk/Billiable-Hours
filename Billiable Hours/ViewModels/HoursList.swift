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
    var sumHours: Double
    var sumDurations: String
    var hourlyRate: String
    var listResults: [ArchivedCalculation]
    var date: Date
    
    init(name: String, sumHours: Double, sumDurations: String, hourlyRate: String, listResults: [ArchivedCalculation], date: Date = .now) {
        self.name = name
        self.sumHours = sumHours
        self.sumDurations = sumDurations
        self.hourlyRate = hourlyRate
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
