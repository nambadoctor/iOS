//
//  PutPatientAllergiesViewModelProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

protocol PutPatientAllergiesProtocol {
    func putPatientAllergiesForAppointment (prescriptionVM:ServiceRequestViewModel, _ completion : @escaping ((_ successfull:Bool)->()))
}
