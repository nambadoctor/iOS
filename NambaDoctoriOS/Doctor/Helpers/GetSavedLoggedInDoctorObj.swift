//
//  GetSavedLoggedInDoctorObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 04/02/21.
//

import Foundation

func getLoggedInDoctor() -> Doctor {
    LocalDecoder.decode(modelType: Doctor.self, from: LocalEncodingK.userObj.rawValue)!
}
