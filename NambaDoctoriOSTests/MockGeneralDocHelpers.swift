//
//  MockGeneralDocHelpers.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockGeneralDoctorHelpers: GeneralDoctorHelpersProtocol {
    
    let generalDocHelpers = GeneralDoctorHelpers()

    var numOfDaysInt:Int? = nil
    func getNumOfDaysFromString(numOfDays: String) -> Int {
        if numOfDaysInt != nil {
            return numOfDaysInt!
        } else {
            return generalDocHelpers.getNumOfDaysFromString(numOfDays: numOfDays)
        }
    }

    func returnNoOfDaysWithIndex(numOfDays: String, timeIndex: Int) -> Int {
        if numOfDaysInt != nil {
            return numOfDaysInt!
        } else {
            return generalDocHelpers.returnNoOfDaysWithIndex(numOfDays: numOfDays, timeIndex: timeIndex)
        }
    }

    var medicineIndexToReturn:Int? = nil
    func getMedicineIndex(medicineArr: [Nambadoctor_V1_MedicineObject], medicine: Nambadoctor_V1_MedicineObject) -> Int {
        if medicineIndexToReturn != nil {
            return medicineIndexToReturn!
        } else {
            return generalDocHelpers.getMedicineIndex(medicineArr: medicineArr, medicine: medicine)
        }
    }
    
    var medicineExists:Bool? = nil
    func checkIfMedicineExists(medicineArr: [Nambadoctor_V1_MedicineObject], medicine: Nambadoctor_V1_MedicineObject) -> Bool {
        if medicineExists != nil {
            return medicineExists!
        } else {
            return generalDocHelpers.checkIfMedicineExists(medicineArr: medicineArr, medicine: medicine)
        }
    }

    var formattedTimingString:String? = nil
    func formatTimingToDecimal(timings: String) -> String {
        if formattedTimingString != nil {
            return formattedTimingString!
        } else {
            return generalDocHelpers.formatTimingToDecimal(timings: timings)
        }
    }

    var timingStringIntoDoubleArr:[Double]? = nil
    func splitTimingStringIntoDoubleArr(timings: String) -> [Double] {
        if timingStringIntoDoubleArr != nil {
            return timingStringIntoDoubleArr!
        } else {
            return generalDocHelpers.splitTimingStringIntoDoubleArr(timings: timings)
        }
    }

    var doubleAsFraction:String? = nil
    func convertingToFraction(decimal: Double) -> String {
        if doubleAsFraction != nil {
            return doubleAsFraction!
        } else {
            return generalDocHelpers.convertingToFraction(decimal: decimal)
        }
    }
}
