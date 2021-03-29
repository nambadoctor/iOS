//
//  ServiceProviderProfile.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

struct ServiceProviderProfile {
    var serviceProviderID:String
    var serviceProviderType:String
    var firstName:String
    var lastName:String
    var specialties:[String]
    var gender:String
    var phoneNumbers:[ServiceProviderPhoneNumber]
    var addresses:[ServiceProviderAddress]
    var applicationInfo:ServiceProviderAppInfo
    var emailAddress:String
    var profilePictureURL:String
    var languages:[String]
    var educations:[ServiceProviderEducation]
    var experiences:[ServiceProviderWorkExperience]
    var serviceFee:Double
    var serviceFeeCurrency:String
    var followUpServiceFee:Double
    var appointmentDuration:Int32
    var intervalBetweenAppointment:Int32
    var status:String
    var registrationNumber:String
    var isActive:Bool
    var createdDate:Int64
    var lastModifiedDate:Int64
}

var sampleServiceProvider = ServiceProviderProfile(serviceProviderID: "",
                                                   serviceProviderType: "",
                                                   firstName: "Rajesh", lastName: "Balasubramaniam",
                                                   specialties: ["Breast Cancer Surgeon", "Neurologist"],
                                                   gender: "Male",
                                                   phoneNumbers: [ServiceProviderPhoneNumber(countryCode: "+91", number: "7530043008", type: "Primary", phoneNumberID: "1"),
                                                                  ServiceProviderPhoneNumber(countryCode: "+91", number: "1234567890", type: "Secondary", phoneNumberID: "2")],
                                                   addresses: [ServiceProviderAddress(streetAddress: "18666 redmond way", state: "Washington", country: "US", pinCode: "98051", type: "Primary", addressID: "1")],
                                                   applicationInfo: ServiceProviderAppInfo(authID: "", authType: "", deviceToken: "", appInfoID: ""),
                                                   emailAddress: "rajeshdr@gmail.com",
                                                   profilePictureURL: "https://firebasestorage.googleapis.com/v0/b/ds-connect.appspot.com/o/Profilepic%2FRajesh.jpeg?alt=media&token=6bbc888c-5633-47df-b21c-efda1b337d51",
                                                   languages: ["English", "Tamil"],
                                                   educations: [ServiceProviderEducation(course: "MBBS", year: 1990, country: "India", college: "Stanley", university: "Stanley", educationID: "1")],
                                                   experiences: [ServiceProviderWorkExperience(organization: "Apollo", startDate: 2005, endDate: 2010, workExperienceID: "1")],
                                                   serviceFee: 500,
                                                   serviceFeeCurrency: "inr",
                                                   followUpServiceFee: 200,
                                                   appointmentDuration: 15,
                                                   intervalBetweenAppointment: 5,
                                                   status: "Available",
                                                   registrationNumber: "123456",
                                                   isActive: true,
                                                   createdDate: Date().millisecondsSince1970,
                                                   lastModifiedDate: Date().millisecondsSince1970
)
