//
//  DocAutoNavigateHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/20/21.
//

import Foundation
 
let docAutoNav:DocAutoNavigateHelper = DocAutoNavigateHelper()
class DocAutoNavigateHelper {
    var appointmentId:String = ""

    var takeToChat:Bool = false
    var takeToTwilioRoom:Bool = false
    var takeToIntermediateView:Bool = false
    
    var currentyInChat:Bool = false
    var currentlyInTwilioRoom:Bool = false
    var currenltyInIntermediateView:Bool = false

    func navigateToChat (appointmentId:String) {
        if currentlyInTwilioRoom {
            DoctorAlertHelpers().presentingStackedNavViewError(navType: "Chat Room")
        } else {
            self.appointmentId = appointmentId
            self.takeToChat = true
            DoctorDefaultModifiers.navigateToClickedNotif()
        }
    }

    func navigateToCall (appointmentId:String) {
        if currentlyInTwilioRoom {
            DoctorAlertHelpers().presentingStackedNavViewError(navType: "Meeting Room")
        } else {
            self.appointmentId = appointmentId
            self.takeToTwilioRoom = true
            DoctorDefaultModifiers.navigateToClickedNotif()
        }
    }

    func enterChatRoom (appointmentId:String) {
        self.appointmentId = appointmentId
        self.currentyInChat = true
        self.currenltyInIntermediateView = true
        self.currentlyInTwilioRoom = false
    }
    
    func enterTwilioRoom (appointmentId:String) {
        self.appointmentId = appointmentId
        self.currentyInChat = false
        self.currenltyInIntermediateView = true
        self.currentlyInTwilioRoom = true
    }
    
    func leaveChatRoom () {
        self.currentyInChat = false
    }
    
    func leaveTwilioRoom () {
        self.currentlyInTwilioRoom = false
    }

    func enterIntermediateView (appointmentId:String) {
        self.appointmentId = appointmentId
        currenltyInIntermediateView = true
    }
    
    func leaveIntermediateView() {
        self.appointmentId = ""
        currenltyInIntermediateView = false
    }
    
    func clearAllValues () {
        appointmentId = ""
        takeToChat = false
        takeToTwilioRoom = false
        takeToIntermediateView = false
    }
}