//
//  RetrievePatientInfoViewModelProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import SwiftUI

protocol RetrievePatientInfoProtocol {

    func getPatientProfile(patientId: String, _ completion: @escaping ((ServiceProviderCustomerProfile?) -> ()))
    
    func getPatientAppointmentList (patientId: String, _ completion: @escaping ((_ appointmentList:[ServiceProviderAppointment]?)->()))
    
    func getUploadedReportList (appointment: ServiceProviderAppointment, _ completion: @escaping ((_ docList:[ServiceProviderReport]?)->()))
    
    func getReportImage (reportId:String, _ completion: @escaping ((_ docList:UIImage?)->()))
}
