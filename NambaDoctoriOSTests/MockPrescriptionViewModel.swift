//
//  MockPrescriptionViewModel.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockPrescriptionViewModel {
    static func getNewPrescriptionVM() -> ServiceRequestViewModel {
        let prescriptionVM = ServiceRequestViewModel(
            appointment: MakeMockAppointment.getAppointment(),
            isNewPrescription: true)
        
        prescriptionVM.prescription = MakeMockPrescription.getPrescription()
        
        return prescriptionVM
    }
    
    static func getAmmendPrescriptionVM() -> ServiceRequestViewModel {
        let prescriptionVM = ServiceRequestViewModel(
            appointment: MakeMockAppointment.getAppointment(),
            isNewPrescription: false)
        
        prescriptionVM.prescription = MakeMockPrescription.getPrescription()
        
        return prescriptionVM
    }
}
