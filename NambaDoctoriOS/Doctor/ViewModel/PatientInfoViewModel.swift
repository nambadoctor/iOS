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
    
    @Published var AppointmentList:[ServiceProviderAppointment]? = nil
    @Published var ReportList:[ServiceProviderReport]? = nil
    
    var patientPhoneNumber:String = ""
    
    var appointment:ServiceProviderAppointment
    private var customerServiceCall:ServiceProviderCustomerServiceProtocol
    private var reportServiceCall:ServiceProviderReportServiceProtocol
    private var appointmentServiceCall:ServiceProviderAppointmentServiceProtocol
    
    init(appointment:ServiceProviderAppointment,
         reportServiceCall:ServiceProviderReportServiceProtocol = ServiceProviderReportService(),
         appointmentServiceCall:ServiceProviderAppointmentServiceProtocol = ServiceProviderAppointmentService(),
         customerServiceCall:ServiceProviderCustomerServiceProtocol = ServiceProviderCustomerService()) {
        
        self.appointment = appointment
        self.customerServiceCall = customerServiceCall
        self.reportServiceCall = reportServiceCall
        self.appointmentServiceCall = appointmentServiceCall
        
        DispatchQueue.global().async {
            self.retrievePatientObj()
            self.retrieveAppointmentList()
        }
    }
    
    func callPatient () {
        callNumber(phoneNumber: self.patientPhoneNumber)
    }
    
    private func retrievePatientObj () {
        customerServiceCall.getPatientProfile(patientId: self.appointment.requestedBy) { (customer) in
            if customer != nil {
                self.patientObj = customer
                self.patientPhoneNumber = self.patientObj.phoneNumbers[0].countryCode + self.patientObj.phoneNumbers[0].number
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
    
    func retrieveUploadedDocumentList (serviceRequestId:String) {
        reportServiceCall.getUploadedReportList(customerId: appointment.customerID, serviceRequestId: serviceRequestId, appointmentId: appointment.appointmentID) { (uploadedDocumentList) in
            if uploadedDocumentList != nil {
                self.ReportList = uploadedDocumentList
            }
        }
    }
    
    func getChildProfile (childId:String) -> ServiceProviderCustomerChildProfile? {
        
        for child in self.patientObj.children {
            if child.ChildProfileId == childId {
                self.patientPhoneNumber = child.PreferredPhoneNumber.mapToNumberString()
                return child
            }
        }
        
        return nil
    }
}
