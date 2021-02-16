//
//  Medicine.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

struct Medicine : Identifiable {
    internal init(id: String = UUID().uuidString, medicineName: String, dosage: String, routeOfAdministration: String, intake: String, duration: Int32, timings: String, specialInstructions: String) {
        self.id = id
        self.medicineName = medicineName
        self.dosage = dosage
        self.routeOfAdministration = routeOfAdministration
        self.intake = intake
        self.duration = duration
        self.timings = timings
        self.specialInstructions = specialInstructions
    }
    
    var id = UUID().uuidString
    var medicineName:String
    var dosage:String
    var routeOfAdministration:String
    var intake:String
    var duration:Int32
    var timings:String
    var specialInstructions:String
}

func MakeEmptyMedicine() -> Medicine {
    return Medicine(id: "", medicineName: "", dosage: "", routeOfAdministration: "", intake: "", duration: 0, timings: "", specialInstructions: "")
}
