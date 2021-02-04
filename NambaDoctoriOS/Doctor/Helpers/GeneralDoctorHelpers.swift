//
//  GeneralDoctorHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class GeneralDoctorHelpers : GeneralDoctorHelpersProtocol {
    
    //MARK: NUM OF DAYS ENCODE TO STRING AND DECODE FROM STRING
     func getNumOfDaysFromString (numOfDays:String) -> Int {
        let split = numOfDays.components(separatedBy: " ")
        var daysInt = Int(split[0]) ?? 0
        if numOfDays == "0" || numOfDays.isEmpty {
            daysInt = 0
        } else if split.count == 2 {
            if split[1] == "Weeks" {
                daysInt *= 7
            } else if split[1] == "Months" {
                daysInt *= 30
            } else if split[1] == "Years" {
                daysInt *= 365
            }
        }
        return daysInt
    }

     func returnNoOfDaysWithIndex (numOfDays:String, timeIndex:Int) -> Int {
        let numOfDaysAsint = Int(numOfDays) ?? 0
        switch timeIndex {
        case 1: //weeks
            return numOfDaysAsint * 7
        case 2: //months
            return numOfDaysAsint * 30
        case 3: //years
            return numOfDaysAsint * 365
        default: //days
            return numOfDaysAsint
        }
    }
    
    //MARK: GETTING INDEX OF PRESCRIPTION
     func getMedicineIndex (medicineArr:[Nambadoctor_V1_MedicineObject],
                            medicine:Nambadoctor_V1_MedicineObject) -> Int {
        var index:Int = 0
        
        for medArrItem in medicineArr {
            if medicine.medicineName == medArrItem.medicineName {
                return index
            }
            index += 1
        }
        
        return index
    }
    
     func checkIfMedicineExists (medicineArr:[Nambadoctor_V1_MedicineObject], medicine:Nambadoctor_V1_MedicineObject) -> Bool {
        for medArrItem in medicineArr {
            if medicine.medicineName == medArrItem.medicineName {
                return true
            }
        }

        return false
    }
    
    //MARK: CONVERTING TIMINGS STRING TO FRACTION DISPLAY
     func formatTimingToDecimal (timings:String) -> String {
        if !timings.isEmpty {
            let split = timings.components(separatedBy: ",")
            
            let mornAsFraction = convertingToFraction(decimal: Double(split[0]) ?? 0)
            let noonAsFraction = convertingToFraction(decimal: Double(split[1]) ?? 0)
            let eveAsFraction = convertingToFraction(decimal: Double(split[2]) ?? 0)
            let nightAsFraction = convertingToFraction(decimal: Double(split[3]) ?? 0)
            
            return "\(mornAsFraction)-\(noonAsFraction)-\(eveAsFraction)-\(nightAsFraction)"
        } else {
            return "0,0,0,0"
        }
    }
    
     func splitTimingStringIntoDoubleArr (timings:String) -> [Double] {
        if !timings.isEmpty {
            let timingStringArr = timings.components(separatedBy: ",")
            
            var timingDoubleArr:[Double] = [Double]()
            
            for timing in timingStringArr {
                timingDoubleArr.append(Double(timing)!)
            }
            
            return timingDoubleArr
        } else {
            return [0.0,0.0,0.0,0.0]
        }
    }
    
     func convertingToFraction (decimal : Double) -> String {
        
        var returnString:String = ""
        
        if decimal.truncatingRemainder(dividingBy: 1) == 0 {
            returnString = "\(decimal.clean)"
        } else {
            let wholeNumber = (decimal - 0.5)

            if wholeNumber != 0 {
                returnString = "\(wholeNumber.clean) 1/2"
            } else {
                returnString = "1/2"
            }
        }

        return returnString
    }
}
