//
//  CustomerProfileMessage.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

struct CustomerProfile {
    var customerID:String
    var firstName:String
    var lastName:String
    var gender:String
    var age:String
    var phoneNumbers:[PhoneNumber]
    var addresses:[CustomerAddress]
    var appInfo:CustomerAppInfo
    var languages:[String]
    var emailAddress:String
    var activeAppointmentIds:[String]
    var completedAppointmentIds:[String]
    var profilePicURL:String
    var primaryServiceProviderID:String
    var Allergies:[CustomerAllergy]
    var MedicalHistories:[CustomerMedicalHistory]
    var lastModifiedDate:Int64
    var createdDate:Int64
    var children:[CustomerChildProfile]
}
