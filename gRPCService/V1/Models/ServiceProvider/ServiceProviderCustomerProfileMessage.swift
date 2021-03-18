//
//  ServiceProviderCustomerProfileMessage.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

struct ServiceProviderCustomerProfileMessage {
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
    var allergies:[String]
    var medicalHistory:[String]
    var lastModifiedDate:Int64
    var createdDate:Int64
}
