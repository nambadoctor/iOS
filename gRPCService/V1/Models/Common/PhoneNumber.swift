//
//  ServiceProviderPhoneNumber.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

struct PhoneNumber : Codable {
    var countryCode:String
    var number:String
    var type:String
    var phoneNumberID:String
}
