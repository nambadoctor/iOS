//
//  CustomerDetailedAppointmentView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/28/21.
//

import SwiftUI
import PDFKit

struct CustomerDetailedAppointmentView: View {
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var customerDetailedAppointmentVM:CustomerDetailedAppointmentViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                if customerDetailedAppointmentVM.refreshViewTrigger {
                    VStack {
                        header
                        
                        VStack {
                            ScrollView (.horizontal) {
                                HStack {
                                    if customerDetailedAppointmentVM.imageLoader != nil {
                                        ImageView(imageLoader: customerDetailedAppointmentVM.imageLoader!)
                                            .padding(.top, 10)
                                    }
                                    
                                    if customerDetailedAppointmentVM.imageLoaders != nil {
                                        ForEach (self.customerDetailedAppointmentVM.imageLoaders!, id: \.id) { loader in
                                            ImageView(imageLoader: loader)
                                        }
                                    }
                                }
                            }
                            
                            if customerDetailedAppointmentVM.prescriptionPDF != nil {
                                PDFKitView(data: customerDetailedAppointmentVM.prescriptionPDF!)
                                    .padding(.top, 10)
                            }
                        }
                        
                        if customerDetailedAppointmentVM.appointmentStarted || customerDetailedAppointmentVM.appointmnentUpComing {
                            allergyEntryView
                                .sheet(isPresented: self.$customerDetailedAppointmentVM.reportsVM.showUploadReportSheet, content: {
                                    UploadReportSheet(reportsVM: self.customerDetailedAppointmentVM.reportsVM, appointment: self.customerDetailedAppointmentVM.appointment)
                                })
                            
                            CustomerReportsView(reportsVM: self.customerDetailedAppointmentVM.reportsVM)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .overlay(appointmentViewBlockers)
                    
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
                    
                    if self.customerDetailedAppointmentVM.killViewTrigger {
                        Text("").onAppear(){self.killView()}
                    }
                }
            }
            CancellationBottomsheetCaller(offset: self.$customerDetailedAppointmentVM.cancellationSheetOffset, cancellationReasons: self.customerDetailedAppointmentVM.CustomerCancellationReasons, delegate: self.customerDetailedAppointmentVM, disclaimerText: self.customerDetailedAppointmentVM.cancellationDisclaimerText)
        }
        .onTapGesture {
            EndEditingHelper.endEditing()
        }
        .onAppear() {
            self.customerDetailedAppointmentVM.getNewChatCount()
            showLoaderListener()
        }
        .environmentObject(self.customerDetailedAppointmentVM.reasonPickerVM)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: navBarChatButton)
    }
    
    var appointmentViewBlockers : some View {
        VStack (alignment: .leading, spacing: 10) {
            if self.customerDetailedAppointmentVM.needToPayFirst {
                needToPayFirstView
            } else if self.customerDetailedAppointmentVM.appointmentIsBeingConfirmed {
                pendingVerification
            }
        }
        .padding()
        .background(self.customerDetailedAppointmentVM.needToPayFirst || self.customerDetailedAppointmentVM.appointmentIsBeingConfirmed ? Color.white : Color.clear)
    }
    
    var pendingVerification : some View {
        VStack (alignment: .leading, spacing: 10) {
            HStack {Spacer()}
            Spacer()
            
            HStack {
                Spacer()
                
                Text("Please wait until your appointment is confirmed!")
                    .font(.title)
                    .bold()
                    .underline()
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding(.bottom, 30)
            
            Text("This can take anywhere between 5 minutes - 1 hour")
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                LargeButton(title: "Cancel Request", disabled: false, backgroundColor: .white, foregroundColor: .red) {
                    self.customerDetailedAppointmentVM.cancelAppointmentBeforePayment { success in
                        if success {
                            CustomerDefaultModifiers.refreshAppointments()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                LargeButton(title: "Contact Support") {
                    openWhatsapp(phoneNumber: "+917530043008", textToSend: "Hello I am having an issue with this appointment")
                }
            }
            Spacer()
        }
    }
    
    var needToPayFirstView : some View {
        VStack (alignment: .leading, spacing: 10) {
            HStack {Spacer()}
            Spacer()
            
            HStack {
                Spacer()
                
                Text("Please Pay To Confirm Your Appointment!")
                    .font(.title)
                    .bold()
                    .underline()
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding(.bottom, 30)
            
            Text("REFUND POLICY")
                .bold()
                .font(.headline)
            
            Text("1) If you cancel before 3 hours of the scheduled time, you will get full refund")
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
            Text("1) If you cancel within 3 hours of the scheduled time, you will get a 30% refund")
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                LargeButton(title: "Stop Booking", disabled: false, backgroundColor: .white, foregroundColor: .red) {
                    self.customerDetailedAppointmentVM.cancelAppointmentBeforePayment { success in
                        if success {
                            CustomerDefaultModifiers.refreshAppointments()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                LargeButton(title: "Pay") {
                    customerDetailedAppointmentVM.makePayment()
                }
            }
            Spacer()
        }
    }
    
    var backButton : some View {
        Button(action : {
            cusAutoNav.leaveDetailedView()
            CustomerDefaultModifiers.refreshAppointments()
            self.presentationMode.wrappedValue.dismiss()
        }){
            Image(systemName: "arrow.left")
                .padding([.top, .bottom, .trailing])
        }
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
    
    var allergyEntryView : some View {
        VStack (alignment: .leading, spacing: 10) {
            if customerDetailedAppointmentVM.serviceRequest != nil {
                Text("ENTER YOUR ALLERGIES (IF ANY)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                
                HStack {
                    ExpandingTextEntryView(text: self.$customerDetailedAppointmentVM.allergy, changeDelegate: self.customerDetailedAppointmentVM.allergyChangedTrigger)
                    
                    if self.customerDetailedAppointmentVM.allergyChanged {
                        Button {
                            self.customerDetailedAppointmentVM.commitAllergy()
                        } label: {
                            Text("Submit")
                        }
                    }
                }
                
                Spacer().frame(height: 17)
                
                Text("SELECT YOUR REASON")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                HStack {
                    ExpandingTextEntryView(text: self.$customerDetailedAppointmentVM.reasonPickerVM.reason, changeDelegate: self.customerDetailedAppointmentVM.reasonChangedTrigger)
                    
                    if self.customerDetailedAppointmentVM.reasonChanged {
                        Button {
                            self.customerDetailedAppointmentVM.commitReason()
                        } label: {
                            Text("Submit")
                        }
                    }
                }
                
                Spacer().frame(height: 17)
            }
        }
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
                            self.customerDetailedAppointmentVM.showCancellationSheet()
                        }, label: {
                            VStack (alignment: .center) {
                                ZStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 60, height: 60)
                                    Image("xmark")
                                        .foregroundColor(.white)
                                        .scaleEffect(1.2)
                                        .padding()
                                }
                                .overlay(Image("xmark")
                                            .foregroundColor(.white)
                                            .scaleEffect(1.2)
                                            .padding())
                                
                                Text("Cancel")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 12))
                            }
                        })
                        Spacer()
                    }
                    
                    
                    Button(action: {
                        self.customerDetailedAppointmentVM.takeToChat = true
                    }, label: {
                        VStack (alignment: .center) {
                            ZStack (alignment: .center) {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 60, height: 60)
                            }
                            .overlay(newMessageIcon)
                            
                            Text("Chat")
                            .foregroundColor(.blue)
                            .font(.system(size: 12))
                        }
                    })
                    
                    Spacer()
                    
                    if !self.customerDetailedAppointmentVM.appointment.IsInPersonAppointment {
                        Button(action: {
                            customerDetailedAppointmentVM.startConsultation()
                        }, label: {
                            
                            VStack (alignment: .center) {
                                ZStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 60, height: 60)
                                }
                                .overlay(Image(systemName: "video")
                                            .scaleEffect(1.2)
                                            .foregroundColor(.white)
                                            .padding())
                                
                                Text("Call")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 12))
                            }
                        })
                        
                    }
                    
                    if self.customerDetailedAppointmentVM.appointment.IsInPersonAppointment {
                        Button {
                            openURL(URL(string: self.customerDetailedAppointmentVM.appointment.Address.googleMapsAddress)!)
                        } label: {
                            VStack (alignment: .center) {
                                ZStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 60, height: 60)
                                }
                                .overlay(Image("location")
                                            .scaleEffect(1.2)
                                            .padding()
                                            .foregroundColor(.white))
                                
                                Text("Directions")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 12))
                            }
                        }

                    }
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                Divider().background(Color.blue.opacity(0.4))
            }
            
            if !customerDetailedAppointmentVM.isPaid {
                LargeButton(title: customerDetailedAppointmentVM.appointmentFinished ? "Pay Now" : "Pay",
                            backgroundColor: customerDetailedAppointmentVM.appointmentFinished ? .green : .gray,
                            foregroundColor: .white) {
                    if customerDetailedAppointmentVM.appointmentFinished {
                        LoggerService().log(eventName: "Consultation done and patient trying to pay")
                        customerDetailedAppointmentVM.makePayment()
                    } else {
                        LoggerService().log(eventName: "Patient trying to pay during consutlation state: \(self.customerDetailedAppointmentVM.appointment.status)")
                        CustomerSnackbarHelpers().waitForConsultationToFinishBeforePaying(doctorName: self.customerDetailedAppointmentVM.appointment.serviceProviderName)
                    }
                }
            } else {
                HStack {
                    Image("checkmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.green)
                        .padding(.trailing)
                    
                    Text("Paid Successfully")
                    
                    Spacer()
                }
            }
        }
    }
    
    private func killView () {
        CustomerDefaultModifiers.refreshAppointments()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var newMessageIcon : some View {
        ZStack (alignment: .center) {
            Image(systemName: "message")
                        .scaleEffect(1.2)
                        .foregroundColor(.white)
                        .padding()
            if self.customerDetailedAppointmentVM.newChats > 0 {
                Text("\(self.customerDetailedAppointmentVM.newChats)")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.bottom, 2)
            }
        }
    }
}

extension CustomerDetailedAppointmentView {
    func showLoaderListener () {
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("\(CustomerViewStatesK.CustomerAppointmentStatusChange)"),
                         object: nil,
                         queue: .main) { (_) in
                self.customerDetailedAppointmentVM.getAppointment { success in
                    if success {
                        self.customerDetailedAppointmentVM.viewSettingChecks()
                    }
                }
            }
    }
}
