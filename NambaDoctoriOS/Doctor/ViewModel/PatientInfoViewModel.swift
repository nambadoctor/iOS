//
//  PatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

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
        
        DispatchQueue.main.async {
            self.retrievePatientObj()
            self.retrieveAppointmentList()
            self.retrieveUploadedDocumentList()
        }
    }

    private func retrievePatientObj () {
        customerServiceCall.getPatientProfile(patientId: self.appointment.requestedBy) { (customer) in
            if customer != nil {
                self.patientObj = customer
                self.patientAllergies = customer?.allergies.last ?? ""
                self.patientMedicalHistory = customer?.medicalHistory.last ?? ""
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
}
