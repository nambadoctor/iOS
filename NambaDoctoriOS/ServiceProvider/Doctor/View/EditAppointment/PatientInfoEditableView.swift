//
//  PatientInfoView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/03/21.
//

import SwiftUI
struct PatientInfoEditableView: View {
    
    @EnvironmentObject var patientInfoViewModel:PatientInfoViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (spacing: 3) {
                Image("folder")
                    .modifier(DetailedAppointmentViewIconModifier())
                
                Text("REPORTS")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                
                Spacer()
                
                Button {
                    self.patientInfoViewModel.imagePickerVM.showActionSheet()
                } label: {
                    Image("plus.circle.fill")
                }
                .modifier(ImagePickerModifier(imagePickerVM: self.patientInfoViewModel.imagePickerVM))

            }

            if self.patientInfoViewModel.ReportList != nil {
                ScrollView (.horizontal) {
                    HStack {
                        ForEach (self.patientInfoViewModel.ReportList!, id: \.reportID) { report in
                            PatientReportView(report: report)
                        }
                    }
                }
            } else if self.patientInfoViewModel.noReports {
                HStack {
                    Text("There are no reports")
                    Spacer()
                }.padding(.top, 5)
            } else {
                Indicator()
            }
        }
        .onAppear() {
            refreshReportListener()
        }
    }
}

extension PatientInfoEditableView {
    func refreshReportListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(DocViewStatesK.refreshReportsChange)"), object: nil, queue: .main) { (_) in
            self.patientInfoViewModel.retrieveUploadedDocumentList(serviceRequestId: self.patientInfoViewModel.appointment.serviceRequestID)
        }
    }
}
