//
//  LoginDefaultMofiers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class LoginDefaultModifiers {
    //MARK: SET LOGIN STATUS (doctor / patient)
    static func signInDoctor (userId:String) {
        UserDefaults.standard.set(UserLoginStatus.Doctor.rawValue, forKey: "\(SimpleStateK.loginStatus)")
        NotificationCenter.default.post(name: NSNotification.Name("\(SimpleStateK.loginStatusChange)"), object: nil)
    }

    static func signInPatient (userId:String) {
        UserDefaults.standard.set(UserLoginStatus.Patient.rawValue, forKey: "\(SimpleStateK.loginStatus)")
        NotificationCenter.default.post(name: NSNotification.Name("\(SimpleStateK.loginStatusChange)"), object: nil)
    }
    
}
