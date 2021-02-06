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
    var askToSavePrescriptionPermission:Bool = false
    var endConsultationPermission:Bool = false
    var dontShowAgainPermission:Bool = false
    
    func writePrescriptionAlert(appointmentId: String, requestedBy: String, navigate: @escaping (Bool) -> ()) {
        navigate(writePrescription)
    }
    
    func amendPrescriptionAlert(amend: @escaping (Bool) -> ()) {
        amend(amendPrescription)
    }
    
    func askToSavePrescriptionAlert (save: @escaping (Bool) -> ()) {
        save(askToSavePrescriptionPermission)
    }
    
    func endConsultationAlert (endConsultation: @escaping (_ ended:Bool) -> (), dontShowAgain: @escaping (_ dontshowAgain:Bool) -> ()) {
        endConsultation(endConsultationPermission)
        dontShowAgain(dontShowAgainPermission)
    }
    
    func patientAddedAlert () {}
}
