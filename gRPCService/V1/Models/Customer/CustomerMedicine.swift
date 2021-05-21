//
//  CustomerMedicineMessage.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

struct CustomerMedicine {
    var medicineName:String
    var dosage:String
    var _dosage:CustomerDosage
    var routeOfAdministration:String
    var intake:String
    var duration:Int32
    var _duration:CustomerDuration
    var timings:String
    var specialInstructions:String
    var medicineID:String
    var notes:String
}
