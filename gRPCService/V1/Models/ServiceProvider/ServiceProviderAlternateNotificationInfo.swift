//
//  ServiceProviderAlternateNotificationInfo.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/20/21.
//

import Foundation

struct ServiceProviderAlternateNotificationInfo : Codable {
    var AlternateNotificationInfoId:String
    var DeviceType:String
    var NotificationProvider:String
    var DeviceToken:String
}
