//
//  LocalCacheHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/14/21.
//

import Foundation

class LocalStorageHelper {
    var phoneNumberDestination:String = "currentUserNumber"
    func storePhoneNumber (number:PhoneNumber) {
        print("STORING PHONE NUMBER")
        LocalEncoder.encode(payload: number, destination: phoneNumberDestination)
    }

    func getPhoneNumber () -> PhoneNumber {
        return LocalDecoder.decode(modelType: PhoneNumber.self, from: phoneNumberDestination)!
    }
}
