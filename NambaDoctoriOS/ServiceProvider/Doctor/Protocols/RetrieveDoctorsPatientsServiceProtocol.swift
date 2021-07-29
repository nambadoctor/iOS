//
//  RetrieveDoctorsPatientsServiceProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import Foundation

protocol RetrieveDoctorsPatientsServiceProtocol {
    func getDoctorsPatients(_ completion: @escaping (([ServiceProviderCustomerProfile]?) -> ()))
}
