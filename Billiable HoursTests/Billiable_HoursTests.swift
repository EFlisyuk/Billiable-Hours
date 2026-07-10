//
//  Billiable_HoursTests.swift
//  Billiable HoursTests
//
//  Created by Елизавета Флисюк on 10/07/2026.
//

import Testing
@testable import Billiable_Hours

struct Billiable_HoursTests {

    @Test func calculate() {
        let model = HoursFieldsModel()
        #expect(model.calculateHours("0", "30", "0") == 0.5)
    }

    @Test func validation() {
        let testCalculation = HoursFieldsModel()
        #expect(testCalculation.isValidMinutes("65") == false)
        #expect(testCalculation.isValidMinutes("59") == true)
        #expect(testCalculation.isValidSeconds("59") == true)
        #expect(testCalculation.isValidSeconds("60") == false)
        #expect(testCalculation.isValidHours("1000") == false)
        #expect(testCalculation.isValidHours("999") == true)
    }
}
