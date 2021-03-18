//
//  GetDocObjectProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation

protocol GetServiceProviderObjectProtocol {
    func fetchServiceProvider (userId:String,
                      completion: @escaping (_ service_provider:ServiceProviderProfile)->())
    func getServiceProvider () -> ServiceProviderProfile
}
