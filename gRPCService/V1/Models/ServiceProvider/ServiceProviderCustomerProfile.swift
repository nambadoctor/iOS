//
//  ServiceProviderCustomerProfileMessage.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

struct ServiceProviderCustomerProfile {
    var customerID:String
    var firstName:String
    var lastName:String
    var gender:String
    var age:String
    var phoneNumbers:[ServiceProviderPhoneNumber]
    var addresses:[ServiceProviderAddress]
    var appInfo:ServiceProviderAppInfo
    var languages:[String]
    var emailAddress:String
    var activeAppointmentIds:[String]
    var completedAppointmentIds:[String]
    var profilePicURL:String
    var primaryServiceProviderID:String
    var lastModifiedDate:Int64
    var createdDate:Int64
}
