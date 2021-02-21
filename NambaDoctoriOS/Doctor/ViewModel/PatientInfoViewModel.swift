//
//  PatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

class PatientInfoViewModel: ObservableObject {
    
    @Published var patientObj:Patient!
    @Published var patientAllergies:String = ""
    @Published var AppointmentList:[Appointment]!
    @Published var ReportList:[Report]!
    
    var appointment:Appointment
    private var retrievePatientInfoHelper:RetrievePatientInfoProtocol
    private var retrievePatientAllergiesHelper:RetrievePatientAllergiesProtocol

    init(appointment:Appointment) {
        self.appointment = appointment
        retrievePatientInfoHelper = RetrievePatientInfoViewModel()
        retrievePatientAllergiesHelper = RetrievePatientAllergiesViewModel()
        
        DispatchQueue.main.async {
            self.retrievePatientObj()
            self.retrieveAppointmentList()
            self.retrievePatientAllergies()
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

    private func retrievePatientAllergies () {
        retrievePatientAllergiesHelper.getPatientAllergies(patientId: appointment.requestedBy) { (allergies) in
            self.patientAllergies = allergies ?? "none"
        }
    }

    func getPrescriptionVMToNavigate() -> PrescriptionViewModel  {
        return PrescriptionViewModel(appointment: appointment, isNewPrescription: false)
    }
}
