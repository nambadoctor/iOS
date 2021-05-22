//
//  DoctorAlertHelperProtocols.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation

protocol DoctorAlertHelpersProtocol {
    func cancelAppointmentAlert (cancel: @escaping (Bool) -> ())
    
    func sendPrescriptionAlert (sendPrescription: @escaping (_ ended:Bool) -> ())
    
    func patientAddedAlert ()
    
    func prescriptionWriteSuccessAlert ()
    
    func twilioConnectToRoomAlert (connect: @escaping (Bool) -> ())
    
    func takeToChatAlert (open: @escaping (Bool) -> ())
    
    func patientUnavailableAlert (patientName:String, completion: @escaping (_ wait:Bool, _ call:Bool) -> ())
    
    func videoCallNotAllowedForChildAlert(call: @escaping (Bool) -> ())
}
