//
//  PatientInfoView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/03/21.
//

import SwiftUI
struct PatientInfoView: View {
    
    @ObservedObject var patientInfoViewModel:PatientInfoViewModel
    var body: some View {
        VStack (alignment: .leading) {
            Text("ALLERGIES:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            ExpandingTextView(text: self.$patientInfoViewModel.patientAllergies)
            
            Text("HISTORY:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            ExpandingTextView(text: self.$patientInfoViewModel.patientMedicalHistory)
            
            Text("Reports:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            if self.patientInfoViewModel.ReportList != nil {
                ScrollView (.horizontal) {
                    HStack {
                        ForEach (self.patientInfoViewModel.ReportList!, id: \.reportID) { report in
                            PatientReportView(report: report)
                        }
                    }
                }
            } else {
                Text("There are no reports")
            }
        }
    }
}
