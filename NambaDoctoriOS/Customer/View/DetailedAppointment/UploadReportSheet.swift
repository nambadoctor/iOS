//
//  UploadReportSheet.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/15/21.
//

import SwiftUI

struct UploadReportSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var reportsVM:CustomerAllReportsViewModel
    var appointment:CustomerAppointment
    
    @State var dummyBinder:Bool = false
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        VStack (alignment: .leading ) {
            Text("Please upload any pictures you would like to share with \(appointment.serviceProviderName)")
                .bold()
                .font(.title2)
                .padding(.bottom)
            
            if reportsVM.reports.isEmpty {
                Spacer()
                HStack {
                    Spacer()
                    VStack (alignment: .center, spacing: 10) {
                        Image("questionmark.folder")
                            .scaleEffect(3)
                            .foregroundColor(.blue)
                            .padding()
                        
                        Text("You have currenly uploaded 0 reports")
                            .bold()
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                }
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach (self.reportsVM.reports, id: \.reportID) { report in
                        CustomerReportCardView(report: report)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                LargeButton(title: self.reportsVM.reports.count > 0 ? "Upload Another" : "Upload Image",
                            backgroundColor: Color.blue) {
                    LoggerService().log(eventName: "Clicking upload image button in upload sheet")
                    reportsVM.imagePickerVM.showActionSheet()
                }
                .modifier(ImagePickerModifier(imagePickerVM: self.reportsVM.imagePickerVM))
                
                if !reportsVM.reports.isEmpty {
                    LargeButton(title: "Done",
                                backgroundColor: Color.green) {
                        LoggerService().log(eventName: "Finished uploading reports in sheet and pressed done")
                        self.reportsVM.dontShowUploadReportSheetAnymore()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }

            if reportsVM.reports.isEmpty {
                HStack {
                    Spacer()
                    Text("SKIP")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .bold()
                }
                .onTapGesture {
                    LoggerService().log(eventName: "Skip Upload Report Sheet")
                    self.reportsVM.dontShowUploadReportSheetAnymore()
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(height: 15)
            }
        }
        .padding()
        .overlay(LoadingScreen(showLoader: self.$reportsVM.showUploadingIndicator, completed: $dummyBinder))
        .onAppear() {LoggerService().log(eventName: "Report Upload Sheet Displayed")}
    }
}
