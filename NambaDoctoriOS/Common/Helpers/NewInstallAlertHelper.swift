//
//  NewInstallAlertHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/30/21.
//

import Foundation
import SwiftUI

class NewInstallAlertHelper {
    func RegisterBeforeBookingAlert (doctorName:String, completion: @escaping (_ register:Bool, _ cancel:Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("To book an appointment with \(doctorName), please register with us first"), primaryButton: Alert.Button.default(Text("Go Back"), action: {
            completion(false, true)
        }), secondaryButton: Alert.Button.default(Text("Register"), action: {
            completion(true, false)
        }))

        CommonDefaultModifiers.showAlert()
    }
    
}
