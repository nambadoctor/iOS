//
//  CheckLoginStatus.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import Foundation

class CheckLoginStatus {
    static func checkStatus (loggedInStatus:String) -> UserLoginStatus {
        switch loggedInStatus {
        case UserLoginStatus.Doctor.rawValue:
            return .Doctor
        case UserLoginStatus.Patient.rawValue:
            return .Patient
        default:
            return .NotSignedIn
        }
    }
}
