//
//  Doctor.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation

struct Doctor: Codable {
    
    var appointmentOnly:Bool
    var consultingFee:Int
    var contactDetails:contactDetails?
    var createdDateTime:String
    var deviceTokenId:String
    var discountedConsultingFee:Int
    var education:education?
    var fullName:String
    var id:String
    var latestAvailableSlot:latestAvailableSlot
    var loginPhoneNumber:String
    var profilePic:String
    var registrationNumber:String
    var specalities:[String]
    var upiId:String
    var work:work?
}
