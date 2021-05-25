//
//  ServiceProviderCustomerChildProfile.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/22/21.
//

import Foundation

struct ServiceProviderCustomerChildProfile : Codable {
    var ChildProfileId:String
    var Name:String
    var Age:String
    var Gender:String
    var PreferredPhoneNumber:PhoneNumber
    var IsPrimaryContact:Bool
}
