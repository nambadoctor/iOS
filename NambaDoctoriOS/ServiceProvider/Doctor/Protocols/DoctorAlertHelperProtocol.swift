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
        
    func prescriptionWriteSuccessAlert ()
    
    func twilioConnectToRoomAlert (connect: @escaping (Bool) -> ())
    
    func takeToChatAlert (open: @escaping (Bool) -> ())
    
    func patientUnavailableAlert (patientName:String, completion: @escaping (_ wait:Bool, _ call:Bool) -> ())
    
    func videoCallNotAllowedForChildAlert(call: @escaping (Bool) -> ())
    
    func callWillTerminateAfterSubmitAlert(completion: @escaping (_ goBack:Bool, _ submit:Bool) -> ())
    
    func errorRetrievingChild (completion: @escaping (Bool) -> ())
    
    func patientAddedAlert (completion: @escaping (_ dismiss:Bool, _ scheduleAppointment:Bool) -> ())
    
    func templateSavedSuccessfullyAlert (completion: @escaping (Bool) -> ())
}
