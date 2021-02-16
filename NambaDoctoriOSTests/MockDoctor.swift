//
//  MockDoctor.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockDoctor {
    static func getDoctor() -> Doctor {
        return Doctor(DoctorId: "", FullName: "", LoginPhoneNumber: "", ProfilePic: "", CreatedDateTime: 0, ConsultationFee: 0, RegistrationNumber: "", Specialities: [String](), Languages: [String](), DeviceTokenId: "", DoctorsContactInfo: [DoctorContactInfo](), DoctorsEducationInfo: [DoctorEducationInfo](), DoctorsExperience: [DoctorExperience](), latestSlot: MockSlotObject.getSlot())
    }
}
