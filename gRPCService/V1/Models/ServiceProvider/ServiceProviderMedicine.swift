//
//  ServiceProviderMedicine.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

struct ServiceProviderMedicine : Codable, Hashable {
    static func == (lhs: ServiceProviderMedicine, rhs: ServiceProviderMedicine) -> Bool {
        return "\(lhs.medicineName)-\(lhs.intakeDosage.Name)".lowercased() == "\(rhs.medicineName)-\(rhs.intakeDosage.Name)".lowercased()
    }
    
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
