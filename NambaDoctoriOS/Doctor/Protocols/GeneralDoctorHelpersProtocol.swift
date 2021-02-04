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
    func getMedicineIndex (medicineArr:[Nambadoctor_V1_MedicineObject], medicine:Nambadoctor_V1_MedicineObject) -> Int
    func checkIfMedicineExists (medicineArr:[Nambadoctor_V1_MedicineObject], medicine:Nambadoctor_V1_MedicineObject) -> Bool
    func formatTimingToDecimal (timings:String) -> String
    func splitTimingStringIntoDoubleArr (timings:String) -> [Double]
    func convertingToFraction (decimal : Double) -> String
}
