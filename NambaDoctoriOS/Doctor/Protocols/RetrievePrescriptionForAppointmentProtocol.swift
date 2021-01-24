//
//  RetrievePrescriptionForAppointmentProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

protocol RetrievePrescriptionForAppointmentProtocol {
    func getPrescription (appointmentId:String, _ completion: @escaping ((_ prescription:Prescription?)->()))
}
