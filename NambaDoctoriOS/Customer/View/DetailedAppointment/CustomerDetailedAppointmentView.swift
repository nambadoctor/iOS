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
            if customerDetailedAppointmentVM.refreshViewTrigger {
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
                        ScrollView {
                            allergyEntryView
                            
                            CustomerReportsView(reportsVM: self.customerDetailedAppointmentVM.reportsVM)
                        }
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
                
                if self.customerDetailedAppointmentVM.killViewTrigger {
                    Text("").onAppear(){self.killView()}
                }
                
                CancellationBottomsheetCaller(offset: self.$customerDetailedAppointmentVM.cancellationSheetOffset, cancellationReasons: self.customerDetailedAppointmentVM.CustomerCancellationReasons, delegate: self.customerDetailedAppointmentVM)
            }
        }
        .onTapGesture {
            EndEditingHelper.endEditing()
        }
        .onAppear() {
            self.customerDetailedAppointmentVM.getNewChatCount()
            showLoaderListener()
        }
        .modifier(CustomerRatingViewModifier(ratingVM: self.customerDetailedAppointmentVM.ratingVM))
        .environmentObject(self.customerDetailedAppointmentVM.reasonPickerVM)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: navBarChatButton)
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
                    ExpandingTextView(text: self.$customerDetailedAppointmentVM.allergy, changeDelegate: self.customerDetailedAppointmentVM.allergyChangedTrigger)

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
                    ExpandingTextView(text: self.$customerDetailedAppointmentVM.reasonPickerVM.reason, changeDelegate: self.customerDetailedAppointmentVM.reasonChangedTrigger)

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
                            self.customerDetailedAppointmentVM.showCancellationSheet()
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
            
            if !customerDetailedAppointmentVM.isPaid {
                LargeButton(title: "Pay Now") {
                    if customerDetailedAppointmentVM.appointmentFinished {
                        customerDetailedAppointmentVM.makePayment()
                    } else {
                        CustomerAlertHelpers().payOnlyAfterAppointmentFinished()
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
                self.customerDetailedAppointmentVM.getAppointment { success in
                    if success {
                        self.customerDetailedAppointmentVM.viewSettingChecks()
                    }
                }
            }
    }
}
