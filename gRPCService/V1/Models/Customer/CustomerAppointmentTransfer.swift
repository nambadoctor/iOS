//
//  CustomerAppointmentTransfer.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/25/21.
//

import Foundation

struct CustomerAppointmentTransfer : Codable {
    var AppointmentTransferId:String
    var TransferredBy:String
    var TransferredTo:String
    var TransferReason:String
    var TransferredTime:Int64
}
