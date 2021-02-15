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
    @Published var ReportList:[Nambadoctor_V1_ReportDownloadObject]!
    
    var appointment:Nambadoctor_V1_AppointmentObject
    private var retrievePatientInfoHelper:RetrievePatientInfoProtocol
    private var retrievePatientAllergiesHelper:RetrievePatientAllergiesProtocol

    init(appointment:Nambadoctor_V1_AppointmentObject) {
        print("INITIALIZING")
        self.appointment = appointment
        retrievePatientInfoHelper = RetrievePatientInfoViewModel()
        retrievePatientAllergiesHelper = RetrievePatientAllergiesViewModel()
        
        retrievePatientObj()
        retrieveAppointmentList()
        retrievePatientAllergies()
        retrieveUploadedDocumentList()
    }
    
    var patientName:String {
        return patientObj.fullName
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
