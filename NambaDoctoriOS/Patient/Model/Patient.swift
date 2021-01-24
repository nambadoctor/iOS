//
//  Patient.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

class Patient: Codable {
    internal init(age: String? = nil, createdDateTime: String? = nil, deviceTokenId: String? = nil, fullName: String? = nil, gender: String? = nil, id: String? = nil, language: String? = nil, phoneNumber: String? = nil, preferredDoctorId: String? = nil) {
        self.age = age
        self.createdDateTime = createdDateTime
        self.deviceTokenId = deviceTokenId
        self.fullName = fullName
        self.gender = gender
        self.id = id
        self.language = language
        self.phoneNumber = phoneNumber
        self.preferredDoctorId = preferredDoctorId
    }

    var age:String!
    var createdDateTime:String!
    var deviceTokenId:String!
    var fullName:String!
    var gender:String!
    var id:String!
    var language:String!
    var phoneNumber:String!
    var preferredDoctorId:String!
}
