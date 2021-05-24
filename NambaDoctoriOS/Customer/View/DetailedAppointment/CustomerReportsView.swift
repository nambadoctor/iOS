//
//  CustomerReportView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/14/21.
//

import SwiftUI

struct CustomerReportsView: View {
    @ObservedObject var reportsVM:CustomerAllReportsViewModel

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

            if !self.reportsVM.reports.isEmpty {
                ScrollView (.horizontal) {
                    HStack {
                        ForEach (self.reportsVM.reports, id: \.reportID) { report in
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
            
            LargeButton(title: self.reportsVM.reports.count > 0 ? "Upload Another Report" : "Upload Report",
                        backgroundColor: Color.blue) {
                reportsVM.imagePickerVM.showActionSheet()
            }
            .modifier(ImagePickerModifier(imagePickerVM: self.reportsVM.imagePickerVM))
        }
    }
}
