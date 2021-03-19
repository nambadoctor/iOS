//
//  ServiceProviderMedicine.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

struct ServiceProviderMedicine : Codable {
    var medicineName:String
    var dosage:String
    var routeOfAdministration:String
    var intake:String
    var duration:Int32
    var timings:String
    var specialInstructions:String
    var medicineID:String
}
