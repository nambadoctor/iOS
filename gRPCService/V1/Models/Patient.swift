//
//  Patient.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

struct Patient : Identifiable {
    internal init(patientID: String, age: String, deviceTokenID: String, fullName: String, language: String, phoneNumber: String, preferredDoctorID: String, createdDateTime: Int64, gender: String) {
        self.patientID = patientID
        self.age = age
        self.deviceTokenID = deviceTokenID
        self.fullName = fullName
        self.language = language
        self.phoneNumber = phoneNumber
        self.preferredDoctorID = preferredDoctorID
        self.createdDateTime = createdDateTime
        self.gender = gender
    }

    var id = UUID().uuidString
    var patientID:String
    var age:String
    var deviceTokenID:String
    var fullName:String
    var language:String
    var phoneNumber:String
    var preferredDoctorID:String
    var createdDateTime:Int64
    var gender:String
}

func MakeEmptyPatient() -> Patient {
    return Patient(patientID: "", age: "", deviceTokenID: "", fullName: "", language: "", phoneNumber: "", preferredDoctorID: "", createdDateTime: Date().millisecondsSince1970, gender: "")
}
