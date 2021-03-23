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
        case UserLoginStatus.ServiceProvider.rawValue:
            return .ServiceProvider
        case UserLoginStatus.Customer.rawValue:
            return .ServiceProvider
        default:
            return .NotSignedIn
        }
    }
}
