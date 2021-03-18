//
//  PutFollowUpAppointmentViewModelProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

protocol PutFollowUpAppointmentViewModelProtocol {
    func makeFollowUpAppointment (prescriptionVM:ServiceRequestViewModel, _ completion : @escaping ((_ successfull:Bool)->()))
    
    func makeFollowUpAppointment (followUpVM:FollowUpAppointmentViewModel, patientId:String, _ completion : @escaping ((_ successfull:Bool)->()))
}
