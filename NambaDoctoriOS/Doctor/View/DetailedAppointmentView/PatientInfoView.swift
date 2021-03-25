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
            Divider().padding(.bottom)
            
            Text("HISTORY:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            ExpandingTextView(text: self.$patientInfoViewModel.patientMedicalHistory)
            Divider()
            
            if self.patientInfoViewModel.ReportList != nil {
                ForEach (self.patientInfoViewModel.ReportList!, id: \.reportID) { report in
                    PatientReportView(report: report)
                }
            }
        }
    }
}
