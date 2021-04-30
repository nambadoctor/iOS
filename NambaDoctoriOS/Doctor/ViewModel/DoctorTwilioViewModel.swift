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
    }

    func startRoom(completion: @escaping (_ success:Bool)->()) {
        docAutoNav.enterTwilioRoom(appointmentId: self.appointment.appointmentID)
        self.twilioAccessTokenHelper.retrieveToken(appointmentId: self.appointment.appointmentID, serviceProviderId: self.appointment.serviceProviderID) { (success, token) in
            if success {
                self.viewController = UIStoryboard(name: "Twilio", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
                self.viewController!.twilioEventDelegate = self
                completion(success)
            } else {
                completion(false)
                //TODO: show doctor alert issue with video call and tell them to use phone. USE LOGS
                //show failed alert
            }
        }
    }

    func fireStartedNotif (_ completion: @escaping (_ success:Bool)->()) {
        let replicatedAppointment = self.appointment //cannot do simultanueous access...
        self.updateAppointmentStatus.updateToStartedConsultation(appointment: &self.appointment) { (success) in
            if success {
                //TODO: LOG - room started, consultation not updated
                completion(success)
                self.docNotificationHelpers.fireStartedConsultationNotif(appointmentTime: replicatedAppointment.scheduledAppointmentStartTime)
            }
        }
        //TODO:- ADD LOGS
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
        do {
            self.viewController?.disconnect(sender: self)
        } catch {
            print(error.localizedDescription)
        }
        self.viewController = nil
        twilioDelegate?.leftRoom()
    }

    func toggleTwilioViewSize() {
        if collapseCall {
            viewController!.expandCall()
            self.collapseCall = false
        } else {
            viewController!.collapseCall()
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
