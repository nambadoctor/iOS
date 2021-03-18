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
    private var retrievePatientInfoHelper:RetrievePatientInfoProtocol

    init(appointment:ServiceProviderAppointment) {
        self.appointment = appointment
        retrievePatientInfoHelper = RetrievePatientInfoViewModel()
        
        DispatchQueue.main.async {
            self.retrievePatientObj()
            self.retrieveAppointmentList()
            self.retrieveUploadedDocumentList()
        }
    }

    private func retrievePatientObj () {
        retrievePatientInfoHelper.getPatientProfile(patientId: self.appointment.requestedBy) { (patient) in
            self.patientObj = patient
        }
    }

    private func retrieveAppointmentList () {
        retrievePatientInfoHelper.getPatientAppointmentList(patientId: appointment.requestedBy) { (aptList) in
            self.AppointmentList = aptList
        }
    }

    private func retrieveUploadedDocumentList () {
        retrievePatientInfoHelper.getUploadedReportList(appointment: appointment) { (uploadedDocList) in
            self.ReportList = uploadedDocList
        }
    }

    func getPrescriptionVMToNavigate() -> ServiceRequestViewModel  {
        return ServiceRequestViewModel(appointment: appointment, isNewPrescription: false)
    }
}
