//
//  SetPopupHelpers.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 03/01/21.
//  Copyright © 2021 SuryaManivannan. All rights reserved.
//

import Foundation
import SwiftUI

class GlobalPopupHelpers {
    static func setErrorAlert () {
        alertTempItem = AlertItem(title: Text("Oops, looks like there was an error"), message: Text("please try again"), dismissButton: .default(Text("OK")))
        CommonDefaultModifiers.showAlert()
    }
    
    static func networkLostAlert () {
        alertTempItem = AlertItem(title: Text("Network Error"), message: Text("Please check your network connectivity before continuing"), dismissButton: .default(Text("OK")))
        CommonDefaultModifiers.showAlert()
    }
    
    static func fillAllFieldsAlert () {
        alertTempItem = AlertItem(title: Text("Error!"), message: Text("Please fill all fields"), dismissButton: .default( Text("Try Again")))
        CommonDefaultModifiers.showAlert()
    }

    static func invalidNumberAlert () {
        alertTempItem = AlertItem(title: Text("Please enter a valid number"), message: Text("Looks like your number is invalid. Please renter"), dismissButton: .default(Text("Dismiss")))
        CommonDefaultModifiers.showAlert()
    }
    
    static func incorrectOTPAlert () {
        alertTempItem = AlertItem(title: Text("Verification Failed"), message: Text("Looks like the OTP you entered is wrong. Please try again."), dismissButton: .default(Text("Dismiss")))
        CommonDefaultModifiers.showAlert()
    }

    static func showImagePickerAlert (_ completion: @escaping ((_ sourceType:UIImagePickerController.SourceType) -> ())) -> Alert {
        let alert = Alert(title: Text("Choose Image"),
                          message: Text("How would you like to select your image?"),
                          primaryButton: .default(Text("Camera")) {
                            completion(.camera)},
                          secondaryButton: Alert.Button.default(Text("Gallery"), action: {
                            completion(.photoLibrary)
                          }))
        return alert
    }
    
    func ThankYouAlert () {
        alertTempItem = AlertItem(title: Text("Thank you!"), dismissButton: .default(Text("Ok")))
        CommonDefaultModifiers.showAlert()
    }
}
