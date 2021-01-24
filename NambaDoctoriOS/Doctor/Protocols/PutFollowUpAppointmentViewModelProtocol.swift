//
//  PutFollowUpAppointmentViewModelProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

protocol PutFollowUpAppointmentViewModelProtocol {
    func makeFollowUpAppointment (prescriptionVM:PrescriptionViewModel, _ completion : @escaping ((_ successfull:Bool)->()))
}
