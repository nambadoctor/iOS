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
        alertTempItem = AlertItem(title: Text("Are you sure?"), message: Text("Do you want to cancel this appointment?"), dismissButton: Alert.Button.destructive(Text("Ok").foregroundColor(Color.black), action: {
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
