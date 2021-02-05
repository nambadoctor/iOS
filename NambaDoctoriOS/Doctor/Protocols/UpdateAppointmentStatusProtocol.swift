//
//  UpdateAppointmentStatusProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation

protocol UpdateAppointmentStatusProtocol {
    func makeAppointmentUpdate (appointment:Nambadoctor_V1_AppointmentObject,
                                completion: @escaping (_ updated:Bool)->())
    
    func toCancelled (appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (_ success:Bool) -> ())
    
    func updateToStartedConsultation (appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (_ success:Bool) -> ())
    
    func updateToFinished (appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (_ success:Bool) -> ())
    
    func updateToFinishedAppointment (appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (_ success:Bool) -> ())
}
