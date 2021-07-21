//
//  CustomerServiceProviderAvailability.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

struct CustomerServiceProviderAvailability {
    var dayOfWeek:Int32
    var startTime:Int64
    var endTime:Int64
    var availabilityConfigID:String
    var paymentType:String
    var organisationId:String
    var addressId:String
    var serviceFees:Double
    var isOrganisationSlot:Bool
}
