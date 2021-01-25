//
//  PreRegisteredPatient.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation

struct PreRegisteredPatient {
    var id = UUID()
    var patientName:String = ""
    var patientGender:String = ""
    var patientAge:String = ""
    var phNumberObj:PhoneNumberObj = PhoneNumberObj()
    var patientAllergies:String = ""
}
