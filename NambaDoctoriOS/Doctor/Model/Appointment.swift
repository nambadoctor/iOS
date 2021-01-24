//
//  Appointments.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 10/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

class Appointment : Codable, Identifiable {
    var createdDateTime:String
    var doctorId:String
    var doctorName:String
    var id:String
    var matchType:String
    var patientName:String
    var paymentStatus:String
    var preferredLanguage:String
    var problemDetails:String
    var requestedBy:String
    var slotDateTime:String
    var slotId:String
    var status:String
}
