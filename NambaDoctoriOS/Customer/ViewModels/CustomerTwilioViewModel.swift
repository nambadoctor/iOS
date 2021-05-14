//
//  CustomerTwilioViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/30/21.
//

import Foundation
import UIKit

class CustomerTwilioViewModel : ObservableObject {
    var appointment:CustomerAppointment
    @Published var status:TwilioStateK = .waitingToStart

    @Published var collapseCall:Bool = false
    @Published var viewController:ViewController? = nil

    @Published var videoEnabled:Bool = false
    @Published var micEnabled:Bool = true

    @Published var participantJoined:Bool = false

    private var docAlertHelpers:CustomerAlertHelpers!
    private var customerNotifHelpers:CustomerNotificationHelper

    var twilioDelegate:TwilioDelegate? = nil

    private var twilioAccessTokenHelper:TwilioAccessTokenProtocol

    init(appointment:CustomerAppointment,
         twilioAccessTokenHelper:TwilioAccessTokenProtocol = RetrieveTwilioAccessToken()) {
        self.appointment = appointment
        self.twilioAccessTokenHelper = twilioAccessTokenHelper
        self.customerNotifHelpers = CustomerNotificationHelper(appointment: appointment)
        //self.docNotificationHelpers = DocNotifHelpers(appointment: self.appointment)
        docAlertHelpers = CustomerAlertHelpers()
    }

    func startRoom(completion: @escaping (_ success:Bool)->()) {
        cusAutoNav.enterTwilioRoom(appointmentId: self.appointment.appointmentID)
        self.twilioAccessTokenHelper.retrieveToken(appointmentId: self.appointment.appointmentID, userId: self.appointment.customerID) { (success, token) in
            if success {
                self.viewController = UIStoryboard(name: "Twilio", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
                self.viewController?.twilioEventDelegate = self
                completion(success)
                self.customerNotifHelpers.callingNotif()
            } else {
                completion(false)
                //TODO: show doctor alert issue with video call and tell them to use phone. USE LOGS
                //show failed alert
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
        self.videoEnabled = true
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
            viewController?.expandCall()
            self.collapseCall = false
        } else {
            viewController?.collapseCall()
            self.collapseCall = true
        }
    }
}

extension CustomerTwilioViewModel : TwilioEventHandlerDelegate {
    
    func hostConnected() {}
    
    func participantConnected() {
        self.participantJoined = true
    }

    func participantDisconnected() {
        self.participantJoined = false
    }
}
