//
//  ServiceProviderIntakeDosage.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/30/21.
//

import Foundation

struct ServiceProviderIntakeDosage : Codable, Hashable {
    static func == (lhs: ServiceProviderIntakeDosage, rhs: ServiceProviderIntakeDosage) -> Bool {
        return lhs.Name.lowercased() == lhs.Name.lowercased()
    }
    
    var Name:String
    var Unit:String
}
