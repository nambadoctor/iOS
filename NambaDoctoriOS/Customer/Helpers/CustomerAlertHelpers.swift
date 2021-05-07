//
//  CustomerAlertHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation
import SwiftUI

class CustomerAlertHelpers {
    func AppointmentBookedAlert (completion: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Successfully Booked Appointment"), primaryButton: Alert.Button.cancel({
            completion(true)
        }))
        CommonDefaultModifiers.showAlert()
    }
    
    func WaitForDoctorToCallFirstAlert (completion: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Please wait for doctor to call you first"), primaryButton: Alert.Button.cancel({
            completion(true)
        }))
        CommonDefaultModifiers.showAlert()
    }
}
