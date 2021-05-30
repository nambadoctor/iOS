//
//  DocNotifHelpersProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation

protocol DocNotifHelpersProtocol {
    func fireCancelNotif (appointmentTime:Int64, cancellationReason:String)
    func fireStartedConsultationNotif (appointmentTime:Int64)
    func fireAppointmentOverNotif()
}
