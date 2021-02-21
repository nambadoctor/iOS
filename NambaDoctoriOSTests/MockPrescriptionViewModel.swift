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
        let prescriptionVM = PrescriptionViewModel(
            appointment: MakeMockAppointment.getAppointment(),
            isNewPrescription: true)
        
        prescriptionVM.prescription = MakeMockPrescription.getPrescription()
        
        return prescriptionVM
    }
    
    static func getAmmendPrescriptionVM() -> PrescriptionViewModel {
        let prescriptionVM = PrescriptionViewModel(
            appointment: MakeMockAppointment.getAppointment(),
            isNewPrescription: false)
        
        prescriptionVM.prescription = MakeMockPrescription.getPrescription()
        
        return prescriptionVM
    }
}
