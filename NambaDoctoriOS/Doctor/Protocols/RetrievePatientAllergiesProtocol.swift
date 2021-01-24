//
//  RetrievePatientAllergiesProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

protocol RetrievePatientAllergiesProtocol {
    func getPatientAllergies (patientId:String, _ completion: @escaping ((_ allergies:String)->()))
}
