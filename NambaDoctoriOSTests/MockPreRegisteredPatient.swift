//
//  MockPreRegisteredPatient.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockPatientObj {
    static func mockPatientObj () -> Patient {
        return Patient(patientID: "", age: "", deviceTokenID: "", fullName: "", language: "", phoneNumber: "", preferredDoctorID: "", createdDateTime: 0, gender: "")
    }
    
    static func mockPreRegPatient () -> PreRegPatient {
        return PreRegPatient(age: "", fullName: "", phoneNumber: "", preferredDoctorID: "", createdDateTime: Date().millisecondsSince1970, gender: "")
    }
}
