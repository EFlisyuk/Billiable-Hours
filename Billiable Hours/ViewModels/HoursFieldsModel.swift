//
//  InputFieldsViewModel.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 09.01.26.
//

import Foundation
import SwiftData

@Model
class HoursFieldsModel {
    var hoursStr: String
    var minutesStr: String
    var secondsStr: String
    var resultDigit: Double
    var resultString: String
    var date: Date = Date()

    init(hoursStr: String = "", minutesStr: String = "", secondsStr: String = "", resultDigit: Double = 0, resultString: String = "", date: Date = .now) {
        self.hoursStr = hoursStr
        self.minutesStr = minutesStr
        self.secondsStr = secondsStr
        self.resultDigit = resultDigit
        self.resultString = resultString
        self.date = date
    }

    func submit() {
        //       guard isValid else { return }
        let hours = calculateHours(hoursStr, minutesStr, secondsStr)
        print("resultDigit \(hours)")
        resultDigit = hours
        resultString = formatted(hoursStr, minutesStr, secondsStr)
    }

    var isValid: Bool {
        isValidMinutes(minutesStr) && isValidSeconds(secondsStr) && isValidHours(hoursStr)
    }


    func isValidMinutes(_ minutes: String) -> Bool {
        guard let minutesInt = Int(minutes) else {
            return false
        }
        if minutesInt > 59 {
            return false
        }
        return true
    }

    func isValidSeconds(_ seconds: String) -> Bool {
        guard let secondsInt = Int(seconds) else {
            return false
        }
        if secondsInt > 59 {
            return false
        }
        return true
    }

    func isValidHours(_ hours: String) -> Bool {
        guard let hoursInt = Int(hours) else {
            return false
        }
        if hoursInt > 999 {
            return false
        }
        print("hours count \(hours.count)")
        return true
    }

    func hoursInt(_ string: String) -> Int {
        var hours = 0
        if string.count > 0 {
            hours = Int(string)!
            return hours
        }
        return hours
    }

    func secondsInt(_ string: String) -> Int {
        if string.count > 0 {
            return Int(string)!
        }
        return 0
    }

    func minutesInt (_ string: String) -> Int {
        if string.count > 0 {
            return Int(string)!
        }
        return 0
    }

    func formatted(_ hours: String, _ minutes: String, _ seconds: String) -> String {
        var formattedStr: [String] = []
        formattedStr.append(hours)
        formattedStr.append(":")
        formattedStr.append(minutes)
        formattedStr.append(":")
        formattedStr.append(seconds)
        let stringResult = String(formattedStr.joined())
        print(stringResult)

        return stringResult
    }

    func calculateHours (_ hours: String, _ minutes: String, _ seconds: String) -> Double {
        let hours = hoursInt(hours)
        let minutes = minutesInt(minutes)
        let seconds = secondsInt(seconds)
        return Double(hours) + Double(minutes) / 60 + Double(seconds) / 3600
    }
}




