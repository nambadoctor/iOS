//
//  CustomerAutoNav.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/8/21.
//

import Foundation
 
let cusAutoNav:CustomerAutoNavigateHelper = CustomerAutoNavigateHelper()
class CustomerAutoNavigateHelper {
    var appointmentId:String = ""

    var takeToChat:Bool = false
    var takeToTwilioRoom:Bool = false
    var takeToDetailedView:Bool = false
    
    var currentyInChat:Bool = false
    var currentlyInTwilioRoom:Bool = false
    var currenltyInIntermediateView:Bool = false
    
    func navigateToDetailedView (appointmentId:String) {
        self.appointmentId = appointmentId
    }

    func navigateToChat (appointmentId:String) {
        if currentlyInTwilioRoom {
            CustomerAlertHelpers().presentingStackedNavViewError(navType: "Chat Room")
        } else {
            self.appointmentId = appointmentId
            self.takeToChat = true
            CustomerDefaultModifiers.navigateToDetailedView()
        }
    }

    func navigateToCall (appointmentId:String) {
        showRepeatingCallNotif = false
        if currentlyInTwilioRoom {
            CustomerAlertHelpers().presentingStackedNavViewError(navType: "Meeting Room")
        } else {
            self.appointmentId = appointmentId
            self.takeToTwilioRoom = true
            
            if currenltyInIntermediateView && self.appointmentId == appointmentId {
                CustomerDefaultModifiers.triggerAppointmentStatusChanges()
            } else {
                CustomerDefaultModifiers.navigateToDetailedView()
            }
        }
    }
    
    func callNotifRecieved (appointmentId:String) {
        if currenltyInIntermediateView && self.appointmentId == appointmentId {
            self.takeToTwilioRoom.toggle()
            CustomerDefaultModifiers.triggerAppointmentStatusChanges()
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
        LocalNotifStorer().clearNewChatsCountForAppointment(appointmentId: self.appointmentId)
        CommonDefaultModifiers.refreshChatCount()
        self.takeToChat = false
        self.currentyInChat = false
    }

    func leaveTwilioRoom () {
        self.currentlyInTwilioRoom = false
        self.takeToTwilioRoom = false
        showRepeatingCallNotif = false
    }

    func enterDetailedView (appointmentId:String) {
        self.appointmentId = appointmentId
        currenltyInIntermediateView = true
    }

    func leaveDetailedView() {
        self.appointmentId = ""
        currenltyInIntermediateView = false
    }

    func clearAllValues () {
        takeToChat = false
        takeToTwilioRoom = false
        takeToDetailedView = false
    }
}
