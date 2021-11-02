//
//  AppointmentSummaryCardView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/9/21.
//

import SwiftUI

struct AppointmentSummaryCardView: View {
    var appointmentSummary:ServiceProviderAppointmentSummary
    @State var presentPDF:Bool = false
    
    var body: some View {
        HStack (alignment: .top) {
            VStack {
                Text(Helpers.ThreeLetterMonthDateString(date: Date(milliseconds: appointmentSummary.AppointmentTime)))
                    .foregroundColor(.white)
                Text(Helpers.getDatePickerStringFromDate(date: Date(milliseconds: appointmentSummary.AppointmentTime))[1])
                    .foregroundColor(.white)
            }
            .padding(15)
            .background(Color.blue)
            .cornerRadius(100)
            
            VStack (alignment: .leading) {
                Button {
                    self.presentPDF.toggle()
                } label: {
                    HStack (spacing: 3) {
                        Image("heart.text.square")
                            .foregroundColor(.blue)
                        
                        Text("Click to view summary")

                        Spacer()
                    }
                }
                .padding(.bottom, 10)
                
                if !appointmentSummary.PrescriptionImageByteString.isEmpty {
                    ImageView(imageLoader: ImageLoader(urlString: appointmentSummary.PrescriptionImageByteString) { _ in })
                }
                
                if !appointmentSummary.PrescriptionImagesUrl.isEmpty {
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach (self.appointmentSummary.PrescriptionImagesUrl, id: \.self) { url in
                                ImageView(imageLoader: ImageLoader(urlString: url) { _ in })
                            }
                        }
                    }
                }

                if !self.appointmentSummary.ReportsList.isEmpty {
                    HStack (spacing: 3) {
                        Image("folder")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("Reports")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()

                        Spacer()
                    }
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach (self.appointmentSummary.ReportsList, id: \.reportID) { report in
                                PatientReportView(report: report)
                            }
                        }
                    }
                }
            }
        }
        .padding(10)
        .sheet(isPresented: self.$presentPDF) {
            PDFKitRepresentedView(appointmentSummary.PdfBytes)
        }
    }
}
