//
//  NewInstallAlertHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/30/21.
//

import Foundation
import SwiftUI

class NewInstallAlertHelper {
    static func ErrorBookingAppointment (doctorName:String, completion: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("To book an appointment with \(doctorName)"), message: Text("Please Try Again"), primaryButton: Alert.Button.default(Text("Register"), action: {
            completion(true)
        }))
        CommonDefaultModifiers.showAlert()
    }
}
