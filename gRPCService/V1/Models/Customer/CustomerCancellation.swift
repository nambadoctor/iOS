//
//  CustomerCancellation.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/23/21.
//

import Foundation

struct CustomerCancellation : Codable {
    var ReasonName:String
    var CancelledTime:Int64
    var CancelledBy:String
    var CancelledByType:String
    var Notes:String
}
