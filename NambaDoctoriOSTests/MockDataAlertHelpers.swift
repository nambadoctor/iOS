//
//  MockDataAlertHelpers.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 21/01/21.
//

@testable import NambaDoctoriOS

class MockDoctorAlertHelpers: DoctorAlertHelpersProtocol {
    
    var writePrescription:Bool = false
    var amendPrescription:Bool = false
    
    func writePrescriptionAlert(appointmentId: String, requestedBy: String, navigate: @escaping (Bool) -> ()) {
        navigate(writePrescription)
    }
    
    func amendPrescriptionAlert(amend: @escaping (Bool) -> ()) {
        amend(amendPrescription)
    }
    
    
}
