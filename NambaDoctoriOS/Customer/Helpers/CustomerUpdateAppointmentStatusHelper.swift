//
//  CustomerUpdateAppointmentStatusHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/2/21.
//

import Foundation

class CustomerUpdateAppointmentStatusHelper {
    
    let AppointmentServiceCalls:CustomerAppointmentServiceProtocol
    
    init(AppointmentServiceCalls:CustomerAppointmentServiceProtocol = CustomerAppointmentService()) {
        self.AppointmentServiceCalls = AppointmentServiceCalls
    }

    func toCancelled (appointment:inout CustomerAppointment, completion: @escaping (_ success:Bool) -> ()) {
        appointment.status = "Cancelled"
                
        AppointmentServiceCalls.setAppointment(appointment: appointment) { (updated) in
            if updated != nil {
                CommonDefaultModifiers.hideLoader()
                completion(true)
            } else { }
        }
    }
}
