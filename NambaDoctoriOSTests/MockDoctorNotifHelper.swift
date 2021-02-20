//
//  MockDoctorNotifHelper.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockDoctorNotifHelper: DocNotifHelpersProtocol {
    func fireCancelNotif (patientToken:String, appointmentTime:Int64) {}
    func fireStartedConsultationNotif (patientToken:String, appointmentTime:Int64) {}
    func fireAppointmentOverNotif(patientToken: String) {}
}
