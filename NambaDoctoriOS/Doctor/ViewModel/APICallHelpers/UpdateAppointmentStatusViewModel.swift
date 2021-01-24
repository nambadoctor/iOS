//
//  UpdateAppointmentStatus.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class UpdateAppointmentStatusViewModel:UpdateAppointmentStatusProtocol {
    
    let appointmentStatusUpdateExtension = "doctor/appointment"
    
    func getParams (appointmentId:String, status:String) -> [String:Any] {
        let parameters: [String: Any] = [
            "id":appointmentId,
            "status":status
        ]
        
        return parameters
    }
    
    func toCancelled (appointmentId:String, completion: @escaping (_ success:Bool) -> ()) {
        let parameters = getParams(appointmentId: appointmentId, status: "Cancelled")
        
        ApiPatchCall.patch(parameters: parameters, extensionURL: appointmentStatusUpdateExtension) {
            (success) in
            completion(success)
        }
    }
    
    func updateToStartedConsultation (appointmentId:String, completion: @escaping (_ success:Bool) -> ()) {
        let parameters = getParams(appointmentId: appointmentId, status: "StartedConsultation")
        
        ApiPatchCall.patch(parameters: parameters, extensionURL: appointmentStatusUpdateExtension) {
            (success) in
            completion(success)
        }
    }
    
    func updateToFinished (appointmentId:String, completion: @escaping (_ success:Bool) -> ()) {
        let parameters = getParams(appointmentId: appointmentId, status: "Finished")
        
        ApiPatchCall.patch(parameters: parameters, extensionURL: appointmentStatusUpdateExtension) {
            (success) in
            completion(success)
        }
    }
    
    func updateToFinishedAppointment (appointmentId:String, completion: @escaping (_ success:Bool) -> ()) {
        let parameters = getParams(appointmentId: appointmentId, status: "FinishedAppointment")
        
        ApiPatchCall.patch(parameters: parameters, extensionURL: appointmentStatusUpdateExtension) {
            (success) in
            completion(success)
        }
    }
}
