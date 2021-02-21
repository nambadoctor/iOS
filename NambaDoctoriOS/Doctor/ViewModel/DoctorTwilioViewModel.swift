//
//  DoctorTwilioViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation
import SwiftUI

class DoctorTwilioViewModel: ObservableObject {
    var appointment:Appointment
    @Published var status:TwilioStateK = .waitingToStart

    private var docAlertHelpers:DoctorAlertHelpersProtocol!
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()

    private var twilioAccessTokenHelper:TwilioAccessTokenProtocol
    private var updateAppointmentStatus:UpdateAppointmentStatusProtocol

    init(appointment:Appointment,
         twilioAccessTokenHelper:TwilioAccessTokenProtocol = RetrieveTwilioAccessToken(),
         updateAppointmentStatus:UpdateAppointmentStatusProtocol = UpdateAppointmentStatusViewModel()) {
        self.appointment = appointment
        self.twilioAccessTokenHelper = twilioAccessTokenHelper
        self.updateAppointmentStatus = updateAppointmentStatus
        docAlertHelpers = DoctorAlertHelpers()
    }

    func startRoom() {
        DispatchQueue.main.async {
            self.twilioAccessTokenHelper.retrieveToken(appointmentId: self.appointment.appointmentID) { (success, token) in
                if success {
                    self.status = .started
                    self.fireStartedNotif()
                } else {
                    //show failed alert
                }
            }
        }
    }
    
    func fireStartedNotif () {
        let replicatedAppointment = self.appointment //cannot do simultanueous access...
        self.updateAppointmentStatus.updateToStartedConsultation(appointment: &self.appointment) { (success) in
            if success {
                DocNotifHelpers.sharedNotifHelpers.fireStartedConsultationNotif(requestedBy: replicatedAppointment.requestedBy, appointmentTime: replicatedAppointment.requestedTime)
            }
        }
    }

    func toggleStatus (defaultChangeString: String) {
        switch defaultChangeString {
        case TwilioStateK.started.rawValue:
            status = .started
        case TwilioStateK.done.rawValue:
            status = .done
        case TwilioStateK.finished.rawValue:
            status = .finished
        case TwilioStateK.disconnected.rawValue:
            self.disconnect()
        default:
            status = .started
        }
    }

    func disconnect() {
        self.status = .disconnected
    }
    
    func endConsultation() {
        docAlertHelpers.endConsultationAlert { (endConsultation) in
            self.status = .finished
        }
        //DoctorDefaultModifiers.endConsultAlertDoNotShow()
    }
    
    func viewPatientInfoClicked() {
        docSheetHelper.showPatientInfoSheet(appointment: appointment)
    }
}
