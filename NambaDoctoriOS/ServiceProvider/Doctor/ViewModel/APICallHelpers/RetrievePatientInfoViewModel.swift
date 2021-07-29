//
//  RetrievePatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

class RetrievePatientInfo: RetrievePatientInfoViewModelProtocol {
    func getPatientProfile(patientId: String, _ completion: @escaping ((Patient) -> ())) {
        <#code#>
    }
    
    func getPatientAppointmentList(patientId: String, _ completion: @escaping (([Appointment]) -> ())) {
        <#code#>
    }
    
    func getUploadedDocumentList(appointmentId: String, _ completion: @escaping (([UploadedDocument]) -> ())) {
        <#code#>
    }
    
    func getDocImage(docId: String, _ completion: @escaping ((UIImage?) -> ())) {
        <#code#>
    }
    
    
}
