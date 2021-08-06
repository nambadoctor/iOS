//
//  DetailedBookDoctorView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import SwiftUI

struct DetailedBookDoctorView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var detailedBookingVM:DetailedBookDocViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 10) {
                    
                    header
                        .modifier(DetailedAppointmentViewCardModifier())
                        .padding(.top)
                    
                    VStack (alignment: .leading) {
                        HStack {Spacer()}
                        HStack {
                            
                            Text("This appointment is for")
                            
                            Menu {
                                
                                Button {
                                    self.detailedBookingVM.bookForMe()
                                } label: {
                                    Text("Me")
                                }
                                
                                if self.detailedBookingVM.customerProfile.children != nil {
                                    ForEach(self.detailedBookingVM.customerProfile.children!, id: \.ChildProfileId) {child in
                                        Button {
                                            self.detailedBookingVM.bookForChild(child: child)
                                        } label: {
                                            Text(child.Name)
                                        }
                                    }
                                }

                                Button {
                                    self.detailedBookingVM.addChildVM.showSheet = true
                                } label: {
                                    Text("Add Profile")
                                }
                                
                            } label: {
                                Text(self.detailedBookingVM.bookingAppointmentFor)
                                Image("chevron.down.circle")
                            }
                            .modifier(AddProfileViewMod(addChildVM: self.detailedBookingVM.addChildVM, customerProfile: self.detailedBookingVM.customerProfile, callback: self.detailedBookingVM.refreshCustomerProfile))
                        }
                        
                        Spacer().frame(height: 15)
                        
                        Text("Reason For Appointment")
     
                        ExpandingTextEntryView(text: self.$detailedBookingVM.reasonVM.reason)
                    }
                    .modifier(DetailedAppointmentViewCardModifier())
                    
                    AvailabilitySelector(availabilitySelectorVM: self.detailedBookingVM.availabilityVM)
                        .modifier(DetailedAppointmentViewCardModifier())

                    if self.detailedBookingVM.slotIsSelected {
                        LargeButton(title: self.detailedBookingVM.availabilityVM.isPrePaySlot ? "Pay and Book Appointment" : "Book Appointment",
                                    backgroundColor: Color.blue) {
                            self.detailedBookingVM.checkTrustScores()
                        }.padding(.horizontal)
                    }
                }
            }

            BookingReasonBottomsheetCaller(offset: self.$detailedBookingVM.preBookingOptionsOffSet, preBookingOptions: self.detailedBookingVM.preBookingOptions, preBookingOptionsCallback: self.detailedBookingVM.preBookingOptionsCallback)
            
            if self.detailedBookingVM.killView {
                Text("").onAppear(){self.presentationMode.wrappedValue.dismiss()}
            }
            
        }
        .background(Color.gray.opacity(0.08))
        .environmentObject(self.detailedBookingVM.reasonVM)
    }

    var header : some View {
        VStack (alignment: .leading) {
            HStack {Spacer()}
            HStack (alignment: .center) {
                
                if detailedBookingVM.docProfPicImageLoader != nil {
                    ImageView(imageLoader: detailedBookingVM.docProfPicImageLoader!, height: 100, width: 100)
                }
                
                VStack (alignment: .leading, spacing: 8) {
                    
                    HStack {
                        Image("person.crop.circle.fill")
                        Text(detailedBookingVM.serviceProviderName)
                            .font(.system(size: 16))
                    }
                    
                    if detailedBookingVM.organization != nil {
                        HStack {
                            Image("building.2")
                            Text(detailedBookingVM.organization!.name)
                                .font(.system(size: 16))
                        }
                    }
                    
                    HStack {
                        Image("indianrupeesign.circle")
                        Text(detailedBookingVM.serviceProviderFee)
                            .font(.system(size: 16))
                    }
                    
                    HStack {
                        Image("cross.circle")
                        Text(detailedBookingVM.serviceProvider.specialties.joined())
                            .font(.system(size: 16))
                    }
                    
                }.padding(.leading, 5)
            }
        }
    }
}
