//
//  MockPrescriptionViewModel.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockPrescriptionViewModel {
    static func getNewPrescriptionVM() -> PrescriptionViewModel {
        return PrescriptionViewModel(
            appointment: MakeMockAppointment.getAppointment(),
            isNewPrescription: true,
            docObjectHelper: MockGetDoctorObjectService())
    }
    
    static func getAmmendPrescriptionVM() -> PrescriptionViewModel {
        return PrescriptionViewModel(
            appointment: MakeMockAppointment.getAppointment(),
            isNewPrescription: false,
            docObjectHelper: MockGetDoctorObjectService())
    }
}
