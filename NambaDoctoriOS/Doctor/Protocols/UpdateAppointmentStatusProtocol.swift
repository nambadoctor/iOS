//
//  UpdateAppointmentStatusProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation

protocol UpdateAppointmentStatusProtocol {
    func getParams (appointmentId:String, status:String) -> [String:Any]
    
    func toCancelled (appointmentId:String, completion: @escaping (_ success:Bool) -> ())
    
    func updateToStartedConsultation (appointmentId:String, completion: @escaping (_ success:Bool) -> ())
    
    func updateToFinished (appointmentId:String, completion: @escaping (_ success:Bool) -> ())
    
    func updateToFinishedAppointment (appointmentId:String, completion: @escaping (_ success:Bool) -> ())
}
