//
//  RetrievePatientInfoViewModelProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import SwiftUI

protocol RetrievePatientInfoProtocol {

    func getPatientProfile(patientId: String, _ completion: @escaping ((Nambadoctor_V1_PatientObject?) -> ()))
    
    func getPatientAppointmentList (patientId: String, _ completion: @escaping ((_ appointmentList:[Appointment]?)->()))
    
    func getUploadedReportList (appointment: Appointment, _ completion: @escaping ((_ docList:[Nambadoctor_V1_ReportDownloadObject]?)->()))
    
    func getReportImage (reportId:String, _ completion: @escaping ((_ docList:UIImage?)->()))

}
