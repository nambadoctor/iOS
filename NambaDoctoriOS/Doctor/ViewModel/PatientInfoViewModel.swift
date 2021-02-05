//
//  PatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

class PatientInfoViewModel: ObservableObject {
    
    @Published var patientObj:Nambadoctor_V1_PatientObject!
    @Published var patientAllergies:String = ""
    @Published var AppointmentList:[Nambadoctor_V1_AppointmentObject]!
    @Published var UploadedDocumentList:[UploadedDocument]!

    var appointment:Nambadoctor_V1_AppointmentObject
    private var retrievePatientInfoHelper:RetrievePatientInfoProtocol
    private var retrievePatientAllergiesHelper:RetrievePatientAllergiesProtocol
    
    init(appointment:Nambadoctor_V1_AppointmentObject) {
        self.appointment = appointment
        retrievePatientInfoHelper = RetrievePatientInfo()
        retrievePatientAllergiesHelper = RetrievePatientAllergiesViewModel()
        
        retrievePatientObj()
        retrieveAppointmentList()
        retrievePatientAllergies()
        retrieveUploadedDocumentList()
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
        retrievePatientInfoHelper.getUploadedDocumentList(appointmentId: appointment.appointmentID) { (uploadedDocList) in
            self.UploadedDocumentList = uploadedDocList
        }
    }

    private func retrievePatientAllergies () {
        retrievePatientAllergiesHelper.getPatientAllergies(patientId: appointment.requestedBy) { (allergies) in
            self.patientAllergies = allergies
        }
    }

    func getPrescriptionVMToNavigate() -> PrescriptionViewModel  {
        return PrescriptionViewModel(appointment: appointment, isNewPrescription: false)
    }
}
