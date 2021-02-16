//
//  LatestSlot.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

struct LatestSlot {
    var id: String
    var doctorID: String
    var bookedBy: String
    var duration: Int32
    var startDateTime: Int64
    var status: String
    var createdDateTime: Int64
}

func MakeEmptySlot() -> LatestSlot {
    return LatestSlot(id: "", doctorID: "", bookedBy: "", duration: 0, startDateTime: 0, status: "", createdDateTime: 0)
}
