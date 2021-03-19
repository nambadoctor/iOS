//
//  UpdateAppointmentStatusProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation

protocol UpdateAppointmentStatusProtocol {
    func toCancelled (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ())
    
    func updateToStartedConsultation (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ())
    
    func updateToFinished (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ())
    
    func updateToFinishedAppointment (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ())
}
