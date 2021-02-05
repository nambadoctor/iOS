//
//  PatientInfoView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import SwiftUI

struct PatientInfoView: View {
    
    @ObservedObject var patientInfoVM:PatientInfoViewModel
    
    init(appointment:Nambadoctor_V1_AppointmentObject) {
        patientInfoVM = PatientInfoViewModel(appointment: appointment)
    }
    
    var body: some View {
        VStack {
            if patientInfoVM.patientObj == nil {
                Indicator()
            } else {
                List {
                    basicDetails
                    reports
                    
                    Text("PATIENT'S PREVIOUS CONSULTATIONS").bold()
                    previousConsultations
                }
                Spacer()
            }
        }
    }
    
    var basicDetails : some View {
        VStack (alignment: .leading) {
            Text("Patient Details")
            Text("Name: \(patientInfoVM.patientObj.fullName)")
            Text("Age: \(patientInfoVM.patientObj.age)")
            Text("Gender: \(patientInfoVM.patientObj.gender)")
            Text("Preferred Language: \(patientInfoVM.patientObj.language)")
            Text("Allergies: \(patientInfoVM.patientAllergies)")
        }
    }
    
    var reports : some View {
        VStack (alignment: .leading) {
            Text("PATIENT REPORTS").bold()
            if patientInfoVM.UploadedDocumentList != nil {
                ForEach (patientInfoVM.UploadedDocumentList, id: \.id) { document in
                    NavigationLink(destination: Text("patient report view")) {
                        Text("patient report card")
                    }
                }
            }
        }
    }

    var previousConsultations : some View {
        VStack {
            if patientInfoVM.AppointmentList != nil {
                ForEach (patientInfoVM.AppointmentList, id: \.appointmentID) { appointment in
                    NavigationLink(destination: ViewPrescription(prescriptionVM: patientInfoVM.getPrescriptionVMToNavigate())) {
                        Text("Click Here") //replace with patient info appointment card
                    }
                }
            }
        }
    }
}
