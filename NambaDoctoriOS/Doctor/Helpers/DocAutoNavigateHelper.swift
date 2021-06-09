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

    func navigateToAppointment (appointmentId:String) {
        if currentlyInTwilioRoom {
            DoctorAlertHelpers().presentingStackedNavViewError(navType: "appointment")
        } else {
            self.appointmentId = appointmentId
            DoctorDefaultModifiers.navigateToClickedNotif()
        }
    }

    func navigateToChat (appointmentId:String) {
        if currentlyInTwilioRoom {
            DoctorAlertHelpers().presentingStackedNavViewError(navType: "chat room")
        } else {
            self.appointmentId = appointmentId
            self.takeToChat = true
            DoctorDefaultModifiers.navigateToClickedNotif()
        }
    }

    func navigateToCall (appointmentId:String) {
        if currentlyInTwilioRoom {
            DoctorAlertHelpers().presentingStackedNavViewError(navType: "meeting room")
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
        LoggerService().log(eventName: "Left Chat Room")
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
        AppointmentID = ""
        self.clearAllValues()
    }

    func clearAllValues () {
        appointmentId = ""
        takeToChat = false
        takeToTwilioRoom = false
        takeToIntermediateView = false
        currentyInChat = false
        currentlyInTwilioRoom = false
        currenltyInIntermediateView = false
    }
}
