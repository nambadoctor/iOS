//
//  MockPreRegisteredPatient.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockPreRegPatient {
    static func mockPatientObj () -> Nambadoctor_V1_PatientObject {
        return Nambadoctor_V1_PatientObject.with {
            $0.patientID = "patientId"
            $0.age = "20"
            $0.deviceTokenID = "deviceTokenId"
            $0.fullName = "fullName"
            $0.language = "language"
            $0.phoneNumber = "phoneNumber"
            $0.preferredDoctorID = "prefferedDocId"
            $0.createdDateTime = 0
            $0.gender = "gender"
        }
    }
}
