//
//  DoctorAlertHelperProtocols.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation

protocol DoctorAlertHelpersProtocol {
    func writePrescriptionAlert (appointmentId:String, requestedBy:String, navigate: @escaping (Bool) -> ())
    
    func amendPrescriptionAlert (amend: @escaping (Bool) -> ())
    
    func askToSavePrescriptionAlert (save: @escaping (Bool) -> ())
    
    func endConsultationAlert (endConsultation: @escaping (_ ended:Bool) -> (), dontShowAgain: @escaping (_ dontshowAgain:Bool) -> ())
    
    func patientAddedAlert ()
}
