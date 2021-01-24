//
//  PreRegisteredPatient.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/01/21.
//

import Foundation

struct PreRegisteredUser {
    internal init(userNumber: String, countryCode: String, verificationId: String) {
        self.userNumber = userNumber
        self.countryCode = countryCode
        self.verificationId = verificationId
    }
    
    var userNumber:String
    var countryCode:String
    var verificationId:String
}
