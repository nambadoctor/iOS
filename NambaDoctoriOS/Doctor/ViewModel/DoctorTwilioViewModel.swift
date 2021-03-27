//
//  DoctorTwilioViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation
import SwiftUI

class DoctorTwilioViewModel: ObservableObject {
    var appointment:ServiceProviderAppointment
    @Published var status:TwilioStateK = .waitingToStart
    
    @Published var collapseCall:Bool = false
    @Published var viewController:ViewController? = nil

    private var docAlertHelpers:DoctorAlertHelpersProtocol!
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()
    private var docNotificationHelpers:DocNotifHelpersProtocol

    private var twilioAccessTokenHelper:TwilioAccessTokenProtocol
    private var updateAppointmentStatus:UpdateAppointmentStatusProtocol
    
    init(appointment:ServiceProviderAppointment,
         twilioAccessTokenHelper:TwilioAccessTokenProtocol = RetrieveTwilioAccessToken(),
         updateAppointmentStatus:UpdateAppointmentStatusProtocol = UpdateAppointmentStatusHelper()) {
        self.appointment = appointment
        self.twilioAccessTokenHelper = twilioAccessTokenHelper
        self.updateAppointmentStatus = updateAppointmentStatus
        self.docNotificationHelpers = DocNotifHelpers(appointment: self.appointment)
        docAlertHelpers = DoctorAlertHelpers()
    }

    func startRoom() {
        DispatchQueue.main.async {
            self.twilioAccessTokenHelper.retrieveToken(appointmentId: self.appointment.appointmentID, serviceProviderId: self.appointment.serviceProviderID) { (success, token) in
                if success {
                    self.viewController = UIStoryboard(name: "Twilio", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
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
                self.docNotificationHelpers.fireStartedConsultationNotif(requestedBy: replicatedAppointment.customerID, appointmentTime: replicatedAppointment.scheduledAppointmentStartTime)
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
    
    func collapseView() {
        if collapseCall {
            viewController!.messageLabel.isHidden = false
            viewController!.disconnectButton.isHidden = false
            viewController!.micButton.isHidden = false
            viewController!.videoToggleButton.isHidden = false
            viewController!.previewView.isHidden = false
            self.collapseCall = false
        } else {
            viewController!.messageLabel.isHidden = true
            viewController!.disconnectButton.isHidden = true
            viewController!.micButton.isHidden = true
            viewController!.videoToggleButton.isHidden = true
            viewController! .previewView.isHidden = true
            self.collapseCall = true
        }
    }
}
