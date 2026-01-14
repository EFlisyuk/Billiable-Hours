//
//  InputFieldsViewModel.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 09.01.26.
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
// clear fields
        hoursStr = ""
        minutesStr = ""
        secondsStr = ""
   }
    
    var isValid: Bool {
        isValidMinutes(minutesStr) && isValidSeconds(secondsStr) && isValidHours(hoursStr)
        }
    
    mutating func delete(at index: Int) {
        guard result.indices.contains(index),
              resultStr.indices.contains(index) else { return }

        result.remove(at: index)
        resultStr.remove(at: index)
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
//        guard let hoursInt = Int(hours) else {
//            return false
//        }
        if hours.count < 1 || hours.count > 3 {
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
//        guard let seconds = string else { return 0 }
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




