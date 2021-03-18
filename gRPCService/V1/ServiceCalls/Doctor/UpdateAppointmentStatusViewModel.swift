//
//  UpdateAppointmentStatus.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class UpdateAppointmentStatusViewModel:UpdateAppointmentStatusProtocol {
    
    var appointmentObjMapper:ServiceProviderAppointmentObjectMapper
    
    init() {
        self.appointmentObjMapper = ServiceProviderAppointmentObjectMapper()
    }
    
    func makeAppointmentUpdate (appointment:ServiceProviderAppointment,
                                completion: @escaping (_ updated:Bool)->()) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        print("child: \(appointment.appointmentID)")
        
        let appointmentClient = Nd_V1_ServiceProviderAppointmentWorkerV1Client(channel: channel)
        
        let request = appointmentObjMapper.localAppointmentToGrpc(appointment: appointment)
        
        let setAptStatus = appointmentClient.setAppointment(request, callOptions: callOptions)
        
        DispatchQueue.main.async {
            do {
                let response = try setAptStatus.response.wait()
                print("Update Appointment \(appointment.status) Success for \(response.id)")
                completion(true)
            } catch {
                print("Update Appointment \(appointment.status) Failure")
                completion(false)
            }
        }
    }
    
    func toCancelled (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {
        appointment.status = "Cancelled"
        
        CommonDefaultModifiers.showLoader()
        
        makeAppointmentUpdate(appointment: appointment) { (updated) in
            if updated {
                CommonDefaultModifiers.hideLoader()
                completion(true)
            } else { }
        }
    }
    
    func updateToStartedConsultation (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {
        
        appointment.status = "StartedConsultation"
        
        makeAppointmentUpdate(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }
    
    func updateToFinished (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {
        
        appointment.status = "Finished"
        
        makeAppointmentUpdate(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }
    
    func updateToFinishedAppointment (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {
        
        appointment.status = "FinishedAppointment"
        
        makeAppointmentUpdate(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }
}
