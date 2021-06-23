//
//  CustomerServiceProviderProfile.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

struct CustomerServiceProviderProfile {
    var serviceProviderID:String
    var serviceProviderType:String
    var firstName:String
    var lastName:String
    var specialties:[String]
    var gender:String
    var addresses:[CustomerAddress]
    var applicationInfo:CustomerAppInfo
    var emailAddress:String
    var profilePictureURL:String
    var languages:[String]
    var educations:[CustomerEducation]
    var experiences:[CustomerWorkExperience]
    var serviceFee:Double
    var serviceFeeCurrency:String
    var followUpServiceFee:Double
    var appointmentDuration:Int32
    var intervalBetweenAppointment:Int32
    var status:String
    var registrationNumber:String
    var isActive:Bool
    var createdDate:Int64
    var LatestSlotStartTime:Int64
    var lastModifiedDate:Int64
    var additionalInfo:CustomerServiceProviderAdditionalInfo
}
