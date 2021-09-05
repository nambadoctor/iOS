//
//  ServiceProviderProfile.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

struct ServiceProviderProfile {
    var serviceProviderID:String
    var serviceProviderType:String?
    var firstName:String?
    var lastName:String?
    var specialties:[String]?
    var gender:String?
    var phoneNumbers:[PhoneNumber]?
    var addresses:[ServiceProviderAddress]?
    var applicationInfo:ServiceProviderAppInfo?
    var emailAddress:String?
    var profilePictureURL:String?
    var languages:[String]?
    var educations:[ServiceProviderEducation]?
    var experiences:[ServiceProviderWorkExperience]?
    var serviceFee:Double?
    var serviceFeeCurrency:String?
    var followUpServiceFee:Double?
    var appointmentDuration:Int32?
    var intervalBetweenAppointment:Int32?
    var status:String?
    var registrationNumber:String?
    var isActive:Bool?
    var createdDate:Int64?
    var lastModifiedDate:Int64?
    var serviceProviderDeviceInfo:DeviceInformation?
    var additionalInfo:ServiceProviderAdditionalInfo?
    var organisationIds:[String]?
    var alternateNotificationInfos:[ServiceProviderAlternateNotificationInfo]?
    var configurableSetting:ServiceProviderConfigurableSettings?
    var configurableEntryFields:[String]?
}
