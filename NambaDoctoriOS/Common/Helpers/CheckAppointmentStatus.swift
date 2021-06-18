//
//  CheckAppointmentStatus.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import Foundation

class CheckAppointmentStatus {
    static func checkStatus (appointmentStatus:String) -> ConsultStateK {
        switch appointmentStatus {
        case ConsultStateK.Confirmed.rawValue:
            return .Confirmed
        case ConsultStateK.FinishedAppointment.rawValue:
            return .FinishedAppointment
        case ConsultStateK.StartedConsultation.rawValue:
            return .StartedConsultation
        case ConsultStateK.Finished.rawValue:
            return .Finished
        default:
            return .Finished
        }
    }
}
