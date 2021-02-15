//
//  UpdateAppointmentStatus.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class UpdateAppointmentStatusViewModel:UpdateAppointmentStatusProtocol {
    
    let appointmentStatusUpdateExtension = "doctor/appointment"

    func makeAppointmentUpdate (appointment:Nambadoctor_V1_AppointmentObject,
                                completion: @escaping (_ updated:Bool)->()) {
        
        CommonDefaultModifiers.showLoader()
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let appointmentClient = Nambadoctor_V1_AppointmentWorkerV1Client(channel: channel)
        
        let request = appointment
        
        let setAptStatus = appointmentClient.upsertNewAppointment(request, callOptions: callOptions)
 
        do {
            let response = try setAptStatus.response.wait()
            print("Update Appointment \(appointment.status) Success for \(response.appointmentID)")
            CommonDefaultModifiers.hideLoader()
            completion(true)
        } catch {
            print("Update Appointment \(appointment.status) Failure")
            completion(false)
        }
        
    }
    
    func toCancelled (appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (_ success:Bool) -> ()) {
        appointment.status = "Cancelled"
        
        makeAppointmentUpdate(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }
    
    func updateToStartedConsultation (appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (_ success:Bool) -> ()) {
        
        appointment.status = "StartedConsultation"
        
        makeAppointmentUpdate(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }
    
    func updateToFinished (appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (_ success:Bool) -> ()) {
        
        appointment.status = "Finished"

        makeAppointmentUpdate(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }

    func updateToFinishedAppointment (appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (_ success:Bool) -> ()) {
        
        appointment.status = "FinishedAppointment"
        
        makeAppointmentUpdate(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }
}
