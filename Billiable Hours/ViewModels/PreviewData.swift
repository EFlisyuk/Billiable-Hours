//
//  PreviewData.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 10/07/2026.
//

import Foundation
import SwiftData

@MainActor

func previewContainer() -> ModelContainer {

    let container = try! ModelContainer(for: HoursFieldsModel.self, HoursList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    let context = container.mainContext

    let testCalc = HoursFieldsModel(hoursStr: "11", minutesStr: "11", secondsStr: "11", resultDigit: 11.186, resultString: "11:11:11")
    let testLists: [HoursList] = [
        HoursList(name: "Test list 1", sumHours: 67.118, sumDurations: "67:07:06", hourlyRate: "3000", listResults: [
            ArchivedCalculation(resultDigit: 11.186, resultString: "11:11:11", date: .now, id: UUID()), ArchivedCalculation(resultDigit: 22.373, resultString: "22:22:22", date: .now, id: UUID()), ArchivedCalculation(resultDigit: 33.559, resultString: "33:33:33", date: .now, id: UUID()) ], date: .now)
    ]

    context.insert(testCalc)
    for list in testLists {
        context.insert(list)
    }

    return container
}
