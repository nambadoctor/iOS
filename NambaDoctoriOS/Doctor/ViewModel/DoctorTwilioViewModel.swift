//
//  DoctorTwilioViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation
import SwiftUI

protocol TwilioDelegate {
    func leftRoom()
}

class DoctorTwilioViewModel: ObservableObject {
    var appointment:ServiceProviderAppointment
    @Published var status:TwilioStateK = .waitingToStart

    @Published var collapseCall:Bool = false
    @Published var viewController:ViewController? = nil

    @Published var videoEnabled:Bool = false
    @Published var micEnabled:Bool = true

    @Published var participantJoined:Bool = false

    private var docAlertHelpers:DoctorAlertHelpersProtocol!
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()
    private var docNotificationHelpers:DocNotifHelpersProtocol
    
    var twilioDelegate:TwilioDelegate? = nil

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
        if TwilioAccessTokenString.isEmpty {
            self.twilioAccessTokenHelper.retrieveToken(appointmentId: self.appointment.appointmentID, serviceProviderId: self.appointment.serviceProviderID) { (success, token) in
                if success {
                    self.viewController = UIStoryboard(name: "Twilio", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    self.viewController!.twilioEventDelegate = self
                } else {
                    //show failed alert
                }
            }
        } else {
            self.viewController = UIStoryboard(name: "Twilio", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.viewController!.twilioEventDelegate = self
        }
    }

    func fireStartedNotif (_ completion: @escaping (_ success:Bool)->()) {
        let replicatedAppointment = self.appointment //cannot do simultanueous access...
        self.updateAppointmentStatus.updateToStartedConsultation(appointment: &self.appointment) { (success) in
            if success {
                completion(success)
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
        self.videoEnabled = false
        self.micEnabled = true
        self.viewController?.disconnect(sender: self)
        twilioDelegate?.leftRoom()
    }

    func toggleTwilioViewSize() {
        if collapseCall {
            viewController!.previewView.isHidden = false
            self.collapseCall = false
        } else {
            viewController!.previewView.isHidden = true
            self.collapseCall = true
        }
    }
}

extension DoctorTwilioViewModel : TwilioEventHandlerDelegate {
    func participantConnected() {
        self.participantJoined = true
    }

    func participantDisconnected() {
        self.participantJoined = false
    }
}
