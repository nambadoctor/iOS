//
//  UserDefaultModifiers.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 03/01/21.
//  Copyright © 2021 SuryaManivannan. All rights reserved.
//

import Foundation

class CommonDefaultModifiers {
    //MARK: TOGGLE LOADER
    static func showLoader () {
        UserDefaults.standard.set(true, forKey: "\(SimpleStateK.showLoader)")
        NotificationCenter.default.post(name: NSNotification.Name("\(SimpleStateK.showLoaderChange)"), object: nil)
    }
    
    static func hideLoader () {
        UserDefaults.standard.set(false, forKey: "\(SimpleStateK.showLoader)")
        NotificationCenter.default.post(name: NSNotification.Name("\(SimpleStateK.showLoaderChange)"), object: nil)
    }
    
    //MARK: SIGNOUT / SIGNIN
    static func signout () {
        UserDefaults.standard.set(false, forKey: "\(SimpleStateK.loginStatus)")
        NotificationCenter.default.post(name: NSNotification.Name("\(SimpleStateK.loginStatusChange)"), object: nil)
    }

    //MARK: POPUP CHANGE
    static func showAlert () {
        UserDefaults.standard.set(true, forKey: "\(SimpleStateK.showPopup)")
        NotificationCenter.default.post(name: NSNotification.Name("\(SimpleStateK.showPopupChange)"), object: nil)
    }
    
    static func hideAlert () {
        UserDefaults.standard.set(false, forKey: "\(SimpleStateK.showPopup)")
        NotificationCenter.default.post(name: NSNotification.Name("\(SimpleStateK.showPopupChange)"), object: nil)
    }
}
