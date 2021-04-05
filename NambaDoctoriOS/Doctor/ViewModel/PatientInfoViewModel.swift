//
//  PatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import UIKit

class PatientInfoViewModel: ObservableObject {
    
    @Published var patientObj:ServiceProviderCustomerProfile!
    
    var patientAllergies:String = ""
    var patientMedicalHistory:String = ""
    
    @Published var AppointmentList:[ServiceProviderAppointment]? = nil
    @Published var ReportList:[ServiceProviderReport]? = nil
    
    var appointment:ServiceProviderAppointment
    private var customerServiceCall:CustomerGetSetServiceCallProtocol
    private var reportServiceCall:ReportGetSetServiceCallProtocol
    private var appointmentServiceCall:AppointmentGetSetServiceCallProtocol
    
    init(appointment:ServiceProviderAppointment,
         reportServiceCall:ReportGetSetServiceCallProtocol = ReportGetSetServiceCall(),
         appointmentServiceCall:AppointmentGetSetServiceCallProtocol = AppointmentGetSetServiceCall(),
         customerServiceCall:CustomerGetSetServiceCallProtocol = CustomerGetSetServiceCall()) {
        
        self.appointment = appointment
        self.customerServiceCall = customerServiceCall
        self.reportServiceCall = reportServiceCall
        self.appointmentServiceCall = appointmentServiceCall
        
        DispatchQueue.global().async {
            self.retrievePatientObj()
            self.retrieveAppointmentList()
            self.retrieveUploadedDocumentList()
        }
    }
    
    var patientAgeGenderInfo : String {
        return "\(patientObj?.age ?? ""), \(patientObj?.gender ?? "")"
    }
    
    var phoneNumber:String {
        return "\(patientObj.phoneNumbers[0].number)"
    }
    
    func callPatient () {
        guard let number = URL(string: "tel://" + patientObj.phoneNumbers[0].number) else { return }
        UIApplication.shared.open(number)
    }

    
    private func retrievePatientObj () {
        customerServiceCall.getPatientProfile(patientId: self.appointment.requestedBy) { (customer) in
            if customer != nil {
                self.patientObj = customer
                self.patientAllergies = customer?.allergies.last ?? ""
                self.patientMedicalHistory = customer?.medicalHistory.last ?? ""
                CommonDefaultModifiers.hideLoader()
            }
        }
    }
 
    private func retrieveAppointmentList () {
        appointmentServiceCall.getCustomerAppointmentList(patientId: appointment.requestedBy) { (aptList) in
            if aptList != nil {
                self.AppointmentList = aptList
            }
        }
    }
    
    private func retrieveUploadedDocumentList () {
        reportServiceCall.getUploadedReportList(customerId: appointment.customerID) { (uploadedDocumentList) in
            if uploadedDocumentList != nil {
                self.ReportList = uploadedDocumentList
            }
        }
    }
    
    func sendToPatient (completion: @escaping (_ success:Bool)->()) {
        var allergiesOrHistoryChanged:Bool = false
        
        if patientObj.allergies.last != patientAllergies {
            print("PatientAllergiesChanged")
            patientObj.allergies.append(patientAllergies)
            allergiesOrHistoryChanged = true
        }
        
        if patientObj.medicalHistory.last != patientMedicalHistory {
            print("PatientMedicalHistoryChanged")
            patientObj.medicalHistory.append(patientMedicalHistory)
            allergiesOrHistoryChanged = true
        }
        
        guard allergiesOrHistoryChanged else {
            completion(true)
            return
        }
        
        print("PatientObject: \(patientObj)")
        customerServiceCall.setPatientProfile(customerProfile: patientObj) { (response) in
            if response != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
