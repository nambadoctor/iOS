//
//  PatientInfoView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import SwiftUI

struct PatientInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var patientInfoVM:PatientInfoViewModel
    
    init(appointment:ServiceProviderAppointment) {
        patientInfoVM = PatientInfoViewModel(appointment: appointment)
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            if patientInfoVM.patientObj == nil {
                Indicator()
            } else {
                
                basicDetails
                Spacer().frame(height: 20)
                
                reports
                Spacer().frame(height: 20)
                
                Text("PATIENT'S PREVIOUS CONSULTATIONS").bold()
                previousConsultations

                Spacer()
            }
        }
        .navigationTitle("Patient Info")
        .navigationBarItems(trailing: closeButton)
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
            if !patientInfoVM.ReportList.isEmpty {
                ForEach (patientInfoVM.ReportList, id: \.id) { report in
                    NavigationLink(destination: PatientReportView(report: report)) {
                        Text(report.name)
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
                        Text("\(appointment.requestedTime)")
                    }
                }
            }
        }
    }
    
    var closeButton : some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
        })
    }
}
