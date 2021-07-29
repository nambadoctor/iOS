//
//  PrescriptionGetSetServiceCallProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

protocol ServiceProviderPrescriptionServiceProtocol {
    func getPrescription (appointmentId:String, serviceRequestId:String, customerId:String, _ completion: @escaping ((_ prescription:ServiceProviderPrescription?)->()))
    func setPrescription(prescription:ServiceProviderPrescription, _ completion : @escaping ((_ successfull:Bool)->()))
    func downloadPrescription(prescriptionID:String, _ completion: @escaping (_ imageData:String?)->())
    func getPrescriptionPDF(customerId:String, serviceProviderId:String, appointmentId:String, serviceRequestId:String, _ completion: @escaping (_ pdfData:Data?)->()) 
}
