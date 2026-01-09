//
//  Model.swift
//  Billiable Hours
//
//  Created by Елизавета Флисюк on 02.01.26.
//

import Foundation

struct HoursToBill: Observable {
    var inputStr: String = ""
    var result: [Double] = []
    
    mutating func submit() {
       guard isValid else { return }
        let hours = calculateHours(inputStr)
           result.append(hours)
//            опционально очистить поле:
        inputStr = ""
   }
    
    var isValid: Bool {
        isValidMinutes(inputStr) && isValidSeconds(inputStr) && isValidMinutes(inputStr)
        }
    
    enum Error {
        case count
        case minutes
        case seconds
    }
    
    
    func isValidCount (_ string: String) -> Bool {
        if string.count > 5 && string.count < 8 {
            print("count succeed")
            return true
        } else {
            print("count \(string.count)")
            return false
        }
    }
    
    func formatNumber(_ string: String) -> String {
        var formattedStr: [Character] = []
        let arrayString = Array(string)
        //        type(of: arrayString)
        for i in arrayString {
            if i.isNumber {
                formattedStr.append(i)
            }
        }
        if isValidCount(string) {
            let index = formattedStr.count - 2
            formattedStr.insert(":", at: index)
            let secondIndex = formattedStr.count - 5
            formattedStr.insert(":", at: secondIndex)
            print("formattedStr succeed \(String(formattedStr))")
            return String(formattedStr)
        }
        
        return String(formattedStr)
    }
    
//        var formattedInputStr = formatNumber(inputStr)
    
    func isValidSeconds(_ string: String) -> Bool {
        let formattedInputStr = formatNumber(string)
        if isValidCount(string) {
            let lastTwo = Int(formattedInputStr.suffix(2))
            guard let optionalLastTwo = lastTwo else {
                return false
            }
            print("seconds \(optionalLastTwo)")
            if optionalLastTwo > 59 {
                print("не может быть больше 59 секунд")
                return false
            }
            return true
        }
        return false
        
    }
    
    
    func isValidMinutes(_ string: String) -> Bool {
        let formattedInputStr = formatNumber(string)
        
        if isValidCount(string) {
            let fourthAndFifthFromEnd = Int(
                formattedInputStr
                    .dropLast(3)   // убрали последние 2 (секунды)
                    .suffix(2)     // взяли следующие 2 (минуты)
            )
            print("minutes \(fourthAndFifthFromEnd!)")
            if fourthAndFifthFromEnd! > 59 {
                print(fourthAndFifthFromEnd!)
                return false
            }
            return true
        }
        return false
    }
    
    func hoursInt(_ string: String) -> Int {
        var hours = 0
        if string.count > 4 {
            hours = Int(string.dropLast(4))!
            return hours
        }
        return hours
    }
    
    func secondsInt (_ string: String) -> Int {
        if string.count > 1 {
            return Int(
                string.suffix(2)     // взяли последние 2 (секунды)
            )!
        }
        return 0
    }
    
    func minutesInt (_ string: String) -> Int {
        if string.count > 2 {
            return Int(
                string
                    .dropLast(2)   // убрали последние 2 (секунды)
                    .suffix(2)     // взяли следующие 2 (минуты)
            )!
        }
        return 0
    }
    

    func calculateHours (_ string: String) -> Double {
        let hours = hoursInt(string)
        let minutes = minutesInt(string)
        let seconds = secondsInt(string)
        return Double(hours) + Double(minutes) / 60 + Double(seconds) / 3600
    }
    
}


//    func calculate(_ hours: Int, _ minutes: Double, _ seconds: Double) -> Double {
//        let hoursMinutes = Double(minutes/60)
//        let totalHours: Double = Double(hours) + Double (minutes/60) + Double(seconds/3600)
//        return totalHours * 1400
//    }
//
//    func calculateHours(_ hours: Int, _ minutes: Double, _ seconds: Double) -> Double {
//        let hoursMinutes = Double(minutes/60)
//        let totalHours: Double = Double(hours) + Double (minutes/60) + Double(seconds/3600)
//        return totalHours
//    }


