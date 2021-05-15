//
//  CustomerReportView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/14/21.
//

import SwiftUI

struct CustomerReportsView: View {
    @ObservedObject var customerDetailedAppointmentVM:CustomerDetailedAppointmentViewModel
    
    var body: some View {
        HStack (spacing: 3) {
            Image("folder")
                .scaleEffect(0.8)
                .foregroundColor(Color.gray)

            Text("REPORTS")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
        }

        if !self.customerDetailedAppointmentVM.reports.isEmpty {
            ScrollView (.horizontal) {
                HStack {
                    ForEach (self.customerDetailedAppointmentVM.reports, id: \.reportID) { report in
                        CustomerReportCardView(report: report)
                    }
                }
            }
        } else {
            HStack {
                Text("You have uploaded 0 reports")
                Spacer()
            }.padding(.top, 5)
        }
    }
}