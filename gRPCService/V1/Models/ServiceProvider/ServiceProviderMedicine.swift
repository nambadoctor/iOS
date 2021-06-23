//
//  ServiceProviderMedicine.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

struct ServiceProviderMedicine : Codable, Hashable {
    var medicineName:String
    var intakeDosage:ServiceProviderIntakeDosage
    var routeOfAdministration:String
    var intake:String
    var _duration:ServiceProviderDuration
    var timings:String
    var specialInstructions:String
    var medicineID:String
    var notes:String
}
