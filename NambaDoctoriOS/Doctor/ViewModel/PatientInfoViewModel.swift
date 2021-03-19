//
//  PatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

class PatientInfoViewModel: ObservableObject {
    
    @Published var patientObj:ServiceProviderCustomerProfile!
    @Published var patientAllergies:String = ""
    @Published var AppointmentList:[ServiceProviderAppointment]!
    @Published var ReportList:[ServiceProviderReport]!
    
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
        customerServiceCall.getPatientProfile(patientId: self.appointment.requestedBy) { (patient) in
            self.patientObj = patient
        }
    }

    private func retrieveAppointmentList () {
        appointmentServiceCall.getCustomerAppointmentList(patientId: appointment.requestedBy) { (aptList) in
            self.AppointmentList = aptList
        }
    }

    private func retrieveUploadedDocumentList () {
        reportServiceCall.getUploadedReportList(customerId: appointment.customerID) { (uploadedDocList) in
            self.ReportList = uploadedDocList
        }
    }

    func getPrescriptionVMToNavigate() -> ServiceRequestViewModel  {
        return ServiceRequestViewModel(appointment: appointment, isNewPrescription: false)
    }
}
