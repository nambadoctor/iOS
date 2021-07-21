//
//  ServiceProviderCustomerVitals.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/20/21.
//

import Foundation

struct ServiceProviderCustomerVitals : Codable {
    var BloodPressure:String
    var BloodSugar:String
    var Height:String
    var Weight:String
    var MenstrualHistory:String
    var ObstetricHistory:String
    var IsSmoker:Bool
    var IsAlcoholConsumer:Bool
}
