//
//  TwilioDefaultModifiers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation

class TwilioDefaultModifiers {
    //MARK: TWILIO STATE HELPERS
    static func twilioSetToStarted () {
        UserDefaults.standard.set(TwilioStateK.started.rawValue,
                                  forKey: DocViewStatesK.postConsultation.rawValue)
        NotificationCenter.default.post(
            name: NSNotification.Name(DocViewStatesK.postConsultationChange.rawValue),
            object: nil)
    }
    
    static func twilioSetToFinished () {
        UserDefaults.standard.set(TwilioStateK.finished.rawValue,
                                  forKey: DocViewStatesK.postConsultation.rawValue)
        NotificationCenter.default.post(
            name: NSNotification.Name(DocViewStatesK.postConsultationChange.rawValue),
            object: nil)
    }
    
    static func twilioSetToDisconnected () {
        UserDefaults.standard.set(TwilioStateK.disconnected.rawValue,
                                  forKey: DocViewStatesK.postConsultation.rawValue)
        NotificationCenter.default.post(
            name: NSNotification.Name(DocViewStatesK.postConsultationChange.rawValue),
            object: nil)
    }
    
    static func twilioSetToDone () {
        UserDefaults.standard.set(TwilioStateK.done.rawValue,
                                  forKey: DocViewStatesK.postConsultation.rawValue)
        NotificationCenter.default.post(
            name: NSNotification.Name(DocViewStatesK.postConsultationChange.rawValue),
            object: nil)
    }
}
