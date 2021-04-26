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
                    .scaleEffect(0.8)
                    .foregroundColor(Color.gray)
                
                Text("REPORTS")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }

            if self.patientInfoViewModel.ReportList != nil {
                ScrollView (.horizontal) {
                    HStack {
                        ForEach (self.patientInfoViewModel.ReportList!, id: \.reportID) { report in
                            PatientReportView(report: report)
                        }
                    }
                }
            } else {
                HStack {
                    Text("There are no reports")
                    Spacer()
                }.padding(.top, 5)
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
