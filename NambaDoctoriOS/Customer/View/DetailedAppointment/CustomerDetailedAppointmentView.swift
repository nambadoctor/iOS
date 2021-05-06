//
//  CustomerDetailedAppointmentView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/28/21.
//

import SwiftUI
import PDFKit

struct CustomerDetailedAppointmentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var customerDetailedAppointmentVM:CustomerDetailedAppointmentViewModel
    
    var body: some View {
        ZStack {

            VStack {
                header
                
                VStack {
                    if customerDetailedAppointmentVM.imageLoader != nil {
                        ImageView(imageLoader: customerDetailedAppointmentVM.imageLoader!)
                    }

                    if customerDetailedAppointmentVM.prescriptionPDF != nil {
                        PDFKitView(data: customerDetailedAppointmentVM.prescriptionPDF!)
                    }
                }
                
                if customerDetailedAppointmentVM.appointmentStarted || customerDetailedAppointmentVM.appointmnentUpComing {
                    AppointmentInProgressView
                }
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
            
        }.padding(.horizontal)
    }

    var AppointmentInProgressView : some View {
        VStack (alignment: .leading, spacing: 10) {
            if customerDetailedAppointmentVM.serviceRequest != nil {
                Text("Do you have any allergies?")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                SideBySideCheckBox(isChecked: self.$customerDetailedAppointmentVM.allergy, title1: "Yes", title2: "No")
                
                Text("Please select your reason")
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
    
    var header : some View {
        VStack (alignment: .leading) {
            Text("Appointment On: \(customerDetailedAppointmentVM.appointmentScheduledStartTime)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .bold()
                .padding(.top)
            
            Divider().background(Color.blue.opacity(0.4))
            
            HStack (alignment: .center) {
                
                if customerDetailedAppointmentVM.docProfPicImageLoader != nil {
                    ImageView(imageLoader: customerDetailedAppointmentVM.docProfPicImageLoader!, height: 100, width: 100)
                }
                
                VStack (alignment: .leading) {
                    Text(customerDetailedAppointmentVM.serviceProviderName)
                    Text(customerDetailedAppointmentVM.serviceProviderFee)
                }
                
                Spacer()
            }

            actionButtons
            
            Divider().background(Color.blue.opacity(0.4))
        }
    }
    
    var actionButtons : some View {
        HStack {
            
            if customerDetailedAppointmentVM.appointmnentUpComing {
                Button(action: {
                    customerDetailedAppointmentVM.cancelAppointment { success in
                        if success {
                            killView()
                        }
                    }
                }, label: {
                    ZStack {
                        Image("xmark")
                            .scaleEffect(1.2)
                            .padding()
                            .foregroundColor(.red)
                    }
                    .overlay(Circle()
                                .fill(Color.red.opacity(0.2))
                                .frame(width: 60, height: 60))
                })
                Spacer()
            }

            Button(action: {
                self.customerDetailedAppointmentVM.takeToChat = true
            }, label: {
                ZStack {
                    Image(systemName: "message")
                        .scaleEffect(1.2)
                        .padding()
                }
                .overlay(Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 60, height: 60))
            })
            
            Spacer()
            
            if !customerDetailedAppointmentVM.appointmentFinished {
                Button(action: {
                    customerDetailedAppointmentVM.startConsultation()
                }, label: {
                    ZStack {
                        Image(systemName: "video")
                            .scaleEffect(1.2)
                            .padding()
                    }
                    .overlay(Circle()
                                .fill(Color.blue.opacity(0.2))
                                .frame(width: 60, height: 60))
                })
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical)
    }
    
    private func killView () {
        self.presentationMode.wrappedValue.dismiss()
    }
}
