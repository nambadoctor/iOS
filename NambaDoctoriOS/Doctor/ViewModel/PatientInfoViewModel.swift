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
        
    @Published var briefPatientDetails:String = ""

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
        }
    }
    
    var phoneNumber:String {
        return "\(patientObj.phoneNumbers[0].number)"
    }
    
    func callPatient () {
        guard let number = URL(string: "tel://" + patientObj.phoneNumbers[0].countryCode + patientObj.phoneNumbers[0].number) else { return }
        UIApplication.shared.open(number)
    }

    
    private func retrievePatientObj () {
        customerServiceCall.getPatientProfile(patientId: self.appointment.requestedBy) { (customer) in
            if customer != nil {
                self.patientObj = customer
                self.briefPatientDetails = "\(self.patientObj.age), \(self.patientObj.gender)"
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
}
