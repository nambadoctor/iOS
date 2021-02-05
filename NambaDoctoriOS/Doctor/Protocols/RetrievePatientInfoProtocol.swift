//
//  RetrievePatientInfoViewModelProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import SwiftUI

protocol RetrievePatientInfoProtocol {
    
    func getPatientProfile(patientId: String, _ completion: @escaping ((Nambadoctor_V1_PatientObject) -> ()))
    
    func getPatientAppointmentList (patientId: String, _ completion: @escaping ((_ appointmentList:[Nambadoctor_V1_AppointmentObject])->()))
    
    func getUploadedDocumentList (appointmentId:String, _ completion: @escaping ((_ docList:[UploadedDocument])->()))
    
    func getDocImage (docId:String, _ completion: @escaping ((_ docList:UIImage?)->()))
    
}
