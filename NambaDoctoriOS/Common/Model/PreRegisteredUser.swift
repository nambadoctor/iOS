//
//  PreRegisteredPatient.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/01/21.
//

import Foundation

struct PreRegisteredUser {
    internal init(phNumberObj:PhoneNumberObj, verificationId: String) {
        self.phNumberObj = phNumberObj
        self.verificationId = verificationId
    }
    
    var phNumberObj:PhoneNumberObj
    var verificationId:String
}
