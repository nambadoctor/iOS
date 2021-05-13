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
                            .padding(.top, 10)
                    }
                    
                    if customerDetailedAppointmentVM.prescriptionPDF != nil {
                        PDFKitView(data: customerDetailedAppointmentVM.prescriptionPDF!)
                            .padding(.top, 10)
                    }
                }
                
                if customerDetailedAppointmentVM.appointmentStarted || customerDetailedAppointmentVM.appointmnentUpComing {
                    AppointmentInProgressView
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            if customerDetailedAppointmentVM.showTwilioRoom {
                CustomerTwilioManager(customerTwilioViewModel: customerDetailedAppointmentVM.customerTwilioViewModel)
                    .onAppear(){self.customerDetailedAppointmentVM.customerTwilioViewModel.viewController?.connect(sender: customerDetailedAppointmentVM)}
            }
            
            if customerDetailedAppointmentVM.takeToChat {
                NavigationLink("",
                               destination: CustomerChatRoomView(chatVM: self.customerDetailedAppointmentVM.customerChatViewModel),
                               isActive: $customerDetailedAppointmentVM.takeToChat)
            }
            
            if customerDetailedAppointmentVM.showPayment {
                customerDetailedAppointmentVM.razorPayEndPoint()
            }
        }
        .onAppear() {
            showLoaderListener()
            customerDetailedAppointmentVM.checkForDirectNavigation()
        }
        .environmentObject(self.customerDetailedAppointmentVM.reasonPickerVM)
        .navigationBarItems(trailing: navBarChatButton)
    }
    
    var navBarChatButton : some View {
        VStack {
            if self.customerDetailedAppointmentVM.appointmentFinished {
                Button(action: {
                    self.customerDetailedAppointmentVM.takeToChat = true
                }, label: {
                    Text("Chat")
                })
            }
        }
    }

    var AppointmentInProgressView : some View {
        VStack (alignment: .leading, spacing: 10) {
            if customerDetailedAppointmentVM.serviceRequest != nil {
                Text("ENTER YOUR ALLERGIES (IF ANY)")
                    .font(.footnote)
                    .foregroundColor(.gray)
 
                HStack {
                    ExpandingTextView(text: self.$customerDetailedAppointmentVM.allergy, changeDelegate: self.customerDetailedAppointmentVM)
                    
                    if self.customerDetailedAppointmentVM.allergyChanged {
                        Button {
                            self.customerDetailedAppointmentVM.commitAllergy()
                        } label: {
                            Text("Submit")
                        }
                    }
                }

                Spacer().frame(height: 15)
                
                Text("SELECT YOUR REASON")
                    .font(.footnote)
                    .foregroundColor(.gray)

                OneLineReasonDisplay()
            }

            Spacer().frame(height: 15)

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
                        Text("You have uploaded 0 reports")
                        Spacer()
                    }.padding(.top, 5)
                }
                
                LargeButton(title: "Click To Upload",
                            backgroundColor: Color.blue) {
                    customerDetailedAppointmentVM.imagePickerVM.showActionSheet()
                }
                .modifier(ImagePickerModifier(imagePickerVM: self.customerDetailedAppointmentVM.imagePickerVM))
            }
        }
        .padding(.top, 10)
    }
    
    var header : some View {
        VStack (alignment: .leading) {
            
            HStack (alignment: .center) {
                
                if customerDetailedAppointmentVM.docProfPicImageLoader != nil {
                    ImageView(imageLoader: customerDetailedAppointmentVM.docProfPicImageLoader!, height: 100, width: 100)
                }
                
                VStack (alignment: .leading, spacing: 8) {
                    
                    HStack {
                        Text(customerDetailedAppointmentVM.serviceProviderName)
                            .font(.system(size: 16))
                    }
                    
                    HStack {
                        Image("indianrupeesign.circle")
                        Text(customerDetailedAppointmentVM.serviceProviderFee)
                            .font(.system(size: 16))
                    }
                    
                    HStack {
                        Image("calendar")
                        Text(customerDetailedAppointmentVM.appointmentScheduledStartTime)
                            .font(.system(size: 16))
                    }
                }.padding(.leading, 5)
                
                Spacer()
            }
            .padding(.top, 10)
            
            actionButtons
            
        }
    }
    
    var actionButtons : some View {
        VStack {
            if !customerDetailedAppointmentVM.appointmentFinished {
                Divider().background(Color.blue.opacity(0.4))
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
                        ZStack (alignment: .center) {
                            Image(systemName: "message")
                                .scaleEffect(1.2)
                                .padding()
                            if self.customerDetailedAppointmentVM.newChats > 0 {
                                Text("\(self.customerDetailedAppointmentVM.newChats)")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .padding(.bottom, 2)
                            }
                        }
                        .overlay(Circle()
                                    .fill(Color.blue.opacity(0.2))
                                    .frame(width: 60, height: 60))
                    })
                    
                    Spacer()
                    
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
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                Divider().background(Color.blue.opacity(0.4))
            }
            else {
                if !customerDetailedAppointmentVM.isPaid {
                    LargeButton(title: "Pay Now") {
                        customerDetailedAppointmentVM.makePayment()
                    }
                } else {
                    HStack {
                        Image("checkmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.green)
                            .padding(.trailing)
                        
                        Text("Paid Successfully")
                    }
                }
            }
        }
    }
    
    private func killView () {
        CustomerDefaultModifiers.refreshAppointments()
        self.presentationMode.wrappedValue.dismiss()
    }
}

extension CustomerDetailedAppointmentView {
    func showLoaderListener () {
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("\(CustomerViewStatesK.CustomerAppointmentStatusChange)"),
                         object: nil,
                         queue: .main) { (_) in
                self.customerDetailedAppointmentVM.resetAllValues()
                self.customerDetailedAppointmentVM.initCalls()
                self.customerDetailedAppointmentVM.checkForDirectNavigation()
            }
    }
}
