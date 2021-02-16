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
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "id-\(title)",
          AnalyticsParameterItemName: title,
          AnalyticsParameterContentType: "cont"
          ])
    }
}
