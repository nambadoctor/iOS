//
//  Doctor.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

struct Doctor {
    internal init(DoctorId: String, FullName: String, LoginPhoneNumber: String, ProfilePic: String, CreatedDateTime: Int64, ConsultationFee: Int32, RegistrationNumber: String, Specialities: [String], Languages: [String], DeviceTokenId: String, DoctorsContactInfo: [DoctorContactInfo], DoctorsEducationInfo: [DoctorEducationInfo], DoctorsExperience: [DoctorExperience], latestSlot: LatestSlot) {
        self.doctorID = DoctorId
        self.fullName = FullName
        self.loginPhoneNumber = LoginPhoneNumber
        self.profilePic = ProfilePic
        self.createdDateTime = CreatedDateTime
        self.consultationFee = ConsultationFee
        self.registrationNumber = RegistrationNumber
        self.specialities = Specialities
        self.languages = Languages
        self.deviceTokenID = DeviceTokenId
        self.doctorsContactInfo = DoctorsContactInfo
        self.doctorsEducationInfo = DoctorsEducationInfo
        self.doctorsExperience = DoctorsExperience
        self.latestSlot = latestSlot
    }

    var doctorID:String
    var fullName:String
    var loginPhoneNumber:String
    var profilePic:String
    var createdDateTime:Int64
    var consultationFee:Int32
    var registrationNumber:String
    var specialities:[String]
    var languages:[String]
    var deviceTokenID:String
    var doctorsContactInfo:[DoctorContactInfo]
    var doctorsEducationInfo:[DoctorEducationInfo]
    var doctorsExperience:[DoctorExperience]
    var latestSlot:LatestSlot
}

func MakeEmptyDoctor() -> Doctor {
    return Doctor(DoctorId: "", FullName: "", LoginPhoneNumber: "", ProfilePic: "", CreatedDateTime: 0, ConsultationFee: 0, RegistrationNumber: "", Specialities: [String](), Languages: [String](), DeviceTokenId: "", DoctorsContactInfo: [DoctorContactInfo](), DoctorsEducationInfo: [DoctorEducationInfo](), DoctorsExperience: [DoctorExperience](), latestSlot: MakeEmptySlot())
}
