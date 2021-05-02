//
//  CustomerDetailedAppointmentView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/28/21.
//

import SwiftUI
import PDFKit

struct CustomerDetailedAppointmentView: View {
    
    @ObservedObject var customerDetailedAppointmentVM:CustomerDetailedAppointmentViewModel
    
    var body: some View {
        ZStack {
            
            ScrollView {
                HStack {
                    Button {
                        self.customerDetailedAppointmentVM.takeToChat = true
                    } label: {
                        Text("Chat")
                    }
                    
                    Button {
                        customerDetailedAppointmentVM.startConsultation()
                    } label: {
                        Text("Call")
                    }
                }
                
                if customerDetailedAppointmentVM.imageLoader != nil {
                    ImageView(imageLoader: customerDetailedAppointmentVM.imageLoader!)
                }
                
                if customerDetailedAppointmentVM.prescriptionPDF != nil {
                    PDFKitView(data: customerDetailedAppointmentVM.prescriptionPDF!)
                }
                
                appointmentFinishedView
            }
            
            if customerDetailedAppointmentVM.showTwilioRoom {
                CustomerTwilioManager(customerTwilioViewModel: customerDetailedAppointmentVM.customerTwilioViewModel)
                    .onAppear(){self.customerDetailedAppointmentVM.customerTwilioViewModel.viewController?.connect(sender: customerDetailedAppointmentVM)}
            }
            
            if customerDetailedAppointmentVM.takeToChat {
                NavigationLink("",
                               destination: CustomerChatRoomView(chatVM: self.customerDetailedAppointmentVM.customerChatViewModel),
                               isActive: $customerDetailedAppointmentVM.takeToChat)
            }
        }
    }
    
    var appointmentFinishedView : some View {
        VStack (alignment: .leading) {
            if customerDetailedAppointmentVM.serviceRequest != nil {
                Text("ALLERGIES:")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                ExpandingTextView(text: self.$customerDetailedAppointmentVM.allergy)
                
                Text("REASON:")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                ExpandingTextView(text: self.$customerDetailedAppointmentVM.reason)
            }
            
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
                        Text("There are no reports")
                        Spacer()
                    }.padding(.top, 5)
                }
                
                LargeButton(title: "Upload Image",
                            backgroundColor: Color.blue) {
                    customerDetailedAppointmentVM.imagePickerVM.showActionSheet()
                }
                .modifier(ImagePickerModifier(imagePickerVM: self.customerDetailedAppointmentVM.imagePickerVM))
            }
        }
    }
}
