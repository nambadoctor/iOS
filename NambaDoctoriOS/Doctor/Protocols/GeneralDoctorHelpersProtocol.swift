//
//  GeneralDoctorHelpersProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

protocol GeneralDoctorHelpersProtocol {
    func getNumOfDaysFromString (numOfDays:String) -> Int
    func returnNoOfDaysWithIndex (numOfDays:String, timeIndex:Int) -> Int
    func getMedicineIndex (medicineArr:[Medicine], medicine:Medicine) -> Int
    func checkIfMedicineExists (medicineArr:[Medicine], medicine:Medicine) -> Bool
    func formatTimingToDecimal (timings:String) -> String
    func splitTimingStringIntoDoubleArr (timings:String) -> [Double]
    func convertingToFraction (decimal : Double) -> String
}
