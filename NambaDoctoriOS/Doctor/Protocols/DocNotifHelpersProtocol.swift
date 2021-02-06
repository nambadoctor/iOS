//
//  DocNotifHelpersProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation

protocol DocNotifHelpersProtocol {
    func fireCancelNotif (patientToken:String, appointmentTime:String)
    func fireStartedConsultationNotif (patientToken:String, appointmentTime:String)
    func fireAppointmentOverNotif(patientToken: String)
}
