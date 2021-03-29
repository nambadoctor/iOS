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
    
    @Published var videoEnabled:Bool = false
    @Published var micEnabled:Bool = false

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
        
        startRoom()
    }

    func startRoom() {
        DispatchQueue.main.async {
            self.twilioAccessTokenHelper.retrieveToken(appointmentId: self.appointment.appointmentID, serviceProviderId: self.appointment.serviceProviderID) { (success, token) in
                if success {
                    print("MAKING VIEW CONTROLLER NOW")
                    self.viewController = UIStoryboard(name: "Twilio", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
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
    
    func toggleVideo () {
        self.viewController?.toggleVideo(sender: self) { _ in
            self.videoEnabled.toggle()
        }
    }
    
    func toggleMic () {
        self.viewController?.toggleMic(sender: self) { _ in
            self.micEnabled.toggle()
        }
    }
    
    func leaveRoom () {
        self.viewController?.disconnect(sender: self)
    }
    
    func collapseView() {
        if collapseCall {
            viewController!.messageLabel.isHidden = false
            viewController!.previewView.isHidden = false
            self.collapseCall = false
        } else {
            viewController!.messageLabel.isHidden = true
            viewController! .previewView.isHidden = true
            self.collapseCall = true
        }
    }
}
