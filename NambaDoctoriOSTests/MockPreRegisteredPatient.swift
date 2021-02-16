//
//  MockPreRegisteredPatient.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockPreRegPatient {
    static func mockPatientObj () -> Patient {
        return Patient(patientID: "", age: "", deviceTokenID: "", fullName: "", language: "", phoneNumber: "", preferredDoctorID: "", createdDateTime: 0, gender: "")
    }
}
