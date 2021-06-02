//
//  ServiceProviderDuration.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/20/21.
//

import Foundation

struct ServiceProviderDuration : Codable, Hashable {
    static func == (lhs: ServiceProviderDuration, rhs: ServiceProviderDuration) -> Bool {
        return lhs.Days.lowercased() == lhs.Days.lowercased()
    }
 
    
    var Days:String
    var Unit:String
}
