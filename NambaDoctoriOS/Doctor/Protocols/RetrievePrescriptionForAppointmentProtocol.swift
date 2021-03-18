//
//  RetrievePrescriptionForAppointmentProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

protocol RetrievePrescriptionForAppointmentProtocol {
    func getPrescription (appointmentId:String, serviceRequestId:String, customerId:String, _ completion: @escaping ((_ prescription:ServiceProviderPrescription?)->()))
}
