//
//  Slot.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation

struct latestAvailableSlot: Codable {
    var bookedBy:String
    var duration:Int
    var id:String
    var startDateTime:String
    var status:String
}
