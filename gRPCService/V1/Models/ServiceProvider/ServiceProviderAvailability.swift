//
//  ServiceProviderAvailability.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

struct ServiceProviderAvailability {
    var dayOfWeek:Int32
    var startTime:Int64
    var endTime:Int64
    var availabilityConfigID:String
    var paymentType:String
    var organisationId:String
}
