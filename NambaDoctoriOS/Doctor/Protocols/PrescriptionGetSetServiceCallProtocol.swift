//
//  PrescriptionGetSetServiceCallProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

protocol PrescriptionGetSetServiceCallProtocol {
    func getPrescription (appointmentId:String, serviceRequestId:String, customerId:String, _ completion: @escaping ((_ prescription:ServiceProviderPrescription?)->()))
    func setPrescription(medicineViewModel:MedicineViewModel, _ completion : @escaping ((_ successfull:Bool)->()))
}
