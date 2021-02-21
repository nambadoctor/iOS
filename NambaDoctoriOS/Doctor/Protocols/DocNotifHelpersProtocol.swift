//
//  DocNotifHelpersProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation

protocol DocNotifHelpersProtocol {
    func getPatientFCMTokenId (requestedBy:String, completion: @escaping (_ retrieved:Bool) -> ())
    func fireCancelNotif (requestedBy:String, appointmentTime:Int64)
    func fireStartedConsultationNotif (requestedBy:String, appointmentTime:Int64)
    func fireAppointmentOverNotif(requestedBy: String)
}
