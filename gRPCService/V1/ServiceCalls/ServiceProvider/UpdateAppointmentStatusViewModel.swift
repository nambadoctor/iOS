//
//  UpdateAppointmentStatus.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class UpdateAppointmentStatusHelper:UpdateAppointmentStatusProtocol {
    
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
