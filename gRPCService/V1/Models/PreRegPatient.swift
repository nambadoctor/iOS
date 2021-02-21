//
//  PreRegPatient.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/02/21.
//

import Foundation

struct PreRegPatient {
    internal init(age: String, fullName: String, phoneNumber: String, preferredDoctorID: String, createdDateTime: Int64, gender: String) {
        self.age = age
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.preferredDoctorID = preferredDoctorID
        self.createdDateTime = createdDateTime
        self.gender = gender
    }
    
    var age:String
    var fullName:String
    var phoneNumber:String
    var preferredDoctorID:String
    var createdDateTime:Int64
    var gender:String
}

func MakeEmptyPreRegPatient () -> PreRegPatient {
    return PreRegPatient(age: "", fullName: "", phoneNumber: "", preferredDoctorID: doctor!.doctorID, createdDateTime: Date().millisecondsSince1970, gender: "")
}
