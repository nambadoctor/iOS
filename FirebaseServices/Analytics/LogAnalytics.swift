//
//  LogAnalytics.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation
import FirebaseAnalytics

class LogAnalytics {
    static func logEvent (title:String) {
        logFirebaseAnalytics(title: title)
    }
    
    static func logFirebaseAnalytics (title:String) {
        Analytics.logEvent(title, parameters: [:])
    }
    
    static func logAppInsights (title:String) {
        
    }
}
