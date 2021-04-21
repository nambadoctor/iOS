//
//  DoctorAlertHelperProtocols.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation

protocol DoctorAlertHelpersProtocol {
    func cancelAppointmentAlert (cancel: @escaping (Bool) -> ())
    
    func endConsultationAlert (endConsultation: @escaping (_ ended:Bool) -> ())
    
    func patientAddedAlert ()
    
    func prescriptionWriteSuccessAlert ()
    
    func twilioConnectToRoomAlert (connect: @escaping (Bool) -> ())
    
    func takeToChatAlert (open: @escaping (Bool) -> ())
}
