//
//  PatientReportsVie.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/19/21.
//

import SwiftUI

struct PatientReportsView: View {
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
    }
}
