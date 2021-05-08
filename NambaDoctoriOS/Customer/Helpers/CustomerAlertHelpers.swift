//
//  CustomerAlertHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation
import SwiftUI

class CustomerAlertHelpers {
    func AppointmentBookedAlert (timeStamp:Int64, completion: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Appointment Booked"), message: Text("Your appointment has been successfully booked for \(Helpers.getTimeFromTimeStamp(timeStamp: timeStamp))"), dismissButton: Alert.Button.destructive(Text("Ok").foregroundColor(Color.black), action: {
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
    
    func presentingStackedNavViewError (navType:String) {
        alertTempItem = AlertItem(title: Text("Cannot Open"), message: Text("Sorry, you cannot open another \(navType) while currently in a meeting"), dismissButton: .default(Text("OK")))
        CommonDefaultModifiers.showAlert()
    }
}
