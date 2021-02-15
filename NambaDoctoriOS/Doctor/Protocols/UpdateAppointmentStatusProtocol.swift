//
//  UpdateAppointmentStatusProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation

protocol UpdateAppointmentStatusProtocol {
    func makeAppointmentUpdate (appointment:Appointment,
                                completion: @escaping (_ updated:Bool)->())
    
    func toCancelled (appointment:inout Appointment, completion: @escaping (_ success:Bool) -> ())
    
    func updateToStartedConsultation (appointment:inout Appointment, completion: @escaping (_ success:Bool) -> ())
    
    func updateToFinished (appointment:inout Appointment, completion: @escaping (_ success:Bool) -> ())
    
    func updateToFinishedAppointment (appointment:inout Appointment, completion: @escaping (_ success:Bool) -> ())
}
