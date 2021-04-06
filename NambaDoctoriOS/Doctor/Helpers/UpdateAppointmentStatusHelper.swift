//
//  UpdateAppointmentStatus.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class UpdateAppointmentStatusHelper:UpdateAppointmentStatusProtocol {
    
    let AppointmentServiceCalls:AppointmentGetSetServiceCallProtocol
    
    init(AppointmentServiceCalls:AppointmentGetSetServiceCallProtocol = AppointmentGetSetServiceCall()) {
        self.AppointmentServiceCalls = AppointmentServiceCalls
    }

    func toCancelled (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {
        appointment.status = "Cancelled"
                
        AppointmentServiceCalls.setAppointment(appointment: appointment) { (updated) in
            if updated {
                CommonDefaultModifiers.hideLoader()
                completion(true)
            } else { }
        }
    }

    func updateToStartedConsultation (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {

        appointment.status = "StartedConsultation"
        appointment.actualAppointmentStartTime = Date().millisecondsSince1970
        
        AppointmentServiceCalls.setAppointment(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }

    func updateToFinished (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {

        appointment.status = "Finished"
        appointment.actualAppointmentStartTime = Date().millisecondsSince1970
        appointment.actualAppointmentEndTime = Date().millisecondsSince1970
        
        AppointmentServiceCalls.setAppointment(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }

    func updateToFinishedAppointment (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {

        appointment.status = "FinishedAppointment"

        AppointmentServiceCalls.setAppointment(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }
}
