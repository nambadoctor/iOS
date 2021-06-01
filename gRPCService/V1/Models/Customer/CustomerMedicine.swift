//
//  CustomerMedicineMessage.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

struct CustomerMedicine {
    var medicineName:String
    var routeOfAdministration:String
    var intakeDosage:CustomerIntakeDosage
    var intake:String
    var duration:Int32
    var _duration:CustomerDuration
    var timings:String
    var specialInstructions:String
    var medicineID:String
    var notes:String
}
