//
//  RetrievePatientInfoViewModelProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import SwiftUI

protocol RetrievePatientInfoProtocol {
    
    func setPatientProfile (customerProfile:ServiceProviderCustomerProfile,
                            completion: @escaping (_ returnId:String?) -> ())

    func getPatientProfile(patientId: String,
                           completion: @escaping (_ profile:ServiceProviderCustomerProfile?) -> ())
}
