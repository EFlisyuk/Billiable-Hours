//
//  InputFieldsViewModel.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 09.01.26.
//

//
//  Model.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 02.01.26.
//

import Foundation

struct HoursFieldsModel: Observable {
    var hoursStr: String = ""
    var minutesStr: String = ""
    var secondsStr: String = ""
    var result: [Double] = []
    var resultStr: [String] = []
    
    mutating func submit() {
//       guard isValid else { return }
        let hours = calculateHours(hoursStr, minutesStr,secondsStr)
        print("result \(hours)")
           result.append(hours)
        resultStr.append(formatted(hoursStr, minutesStr,secondsStr))
//            опционально очистить поле:
        hoursStr = ""
        minutesStr = ""
        secondsStr = ""
   }
    
//    var isValid: Bool {
//        isValidMinutes(inputStr) && isValidSeconds(inputStr) && isValidMinutes(inputStr)
//        }

    
    func hoursInt(_ string: String) -> Int {
        var hours = 0
        if string.count > 0 {
            hours = Int(string)!
            return hours
        }
        return hours
    }
    
    func secondsInt(_ string: String) -> Int {
//        guard let seconds = string else { return 0 }
        if string.count > 0 {
            return Int(string)!    // взяли последние 2 (секунды))!
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




