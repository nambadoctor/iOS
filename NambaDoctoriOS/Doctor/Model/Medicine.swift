//
//  Medicine.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class Medicine: Codable, Identifiable {
    internal init(dosage: String, intake: String, medicineName: String, numOfDays: Int, splInstructions: String, routeOfAdmission: String, timings: String) {
        self.dosage = dosage
        self.intake = intake
        self.medicineName = medicineName
        self.numOfDays = numOfDays
        self.splInstructions = splInstructions
        self.routeOfAdmission = routeOfAdmission
        self.timings = timings
    }

    var id:String? = UUID().uuidString
    var dosage:String
    var intake:String
    var medicineName:String
    var numOfDays:Int
    var splInstructions:String
    var routeOfAdmission:String
    var timings:String
}
