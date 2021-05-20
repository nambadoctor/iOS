//
//  ServiceProviderCancellation.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/19/21.
//

import Foundation

struct ServiceProviderCancellation : Codable {
    var ReasonName:String
    var CancelledTime:Int64
    var CancelledBy:String
    var CancelledByType:String
    var Notes:String
}
