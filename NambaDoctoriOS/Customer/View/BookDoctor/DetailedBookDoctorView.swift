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
        ScrollView {
            VStack (alignment: .leading, spacing: 10) {
                Group {
                    header
                    
                    Divider().background(Color.blue)
                    
                    HStack {
                        
                        Text("This appointment is for")
                        
                        Menu {
                            
                            Button {
                                self.detailedBookingVM.bookForMe()
                            } label: {
                                Text("Me")
                            }
                            
                            ForEach(self.detailedBookingVM.customerProfile.children, id: \.ChildProfileId) {child in
                                Button {
                                    self.detailedBookingVM.bookForChild(child: child)
                                } label: {
                                    Text(child.Name)
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

                    Spacer().frame(height: 10)
                    
                    Text("Reason For Appointment")
                    
                    ExpandingTextView(text: self.$detailedBookingVM.reasonVM.reason)
                    
                    Spacer().frame(height: 10)
                    
                    Text("Choose a Date")
                }
                
                if !detailedBookingVM.dateDisplay.isEmpty {
                    ScrollView (.horizontal) {
                        HStack (spacing: 5) {
                            ForEach (detailedBookingVM.dateDisplay, id: \.self) {date in
                                VStack (spacing: 5) {
                                    Text(Helpers.load3LetterDayName(timeStamp: date))
                                    Text("\(Helpers.loadDate(timeStamp: date)) \(Helpers.load3LetterMonthName(timeStamp: date))")
                                }
                                .padding(8)
                                .background(detailedBookingVM.selectedDate == date ? Color.blue.opacity(0.2) : Color.white)
                                .cornerRadius(5)
                                .shadow(radius: 2)
                                .padding(.vertical, 7)
                                .padding(.horizontal, 5)
                                .onTapGesture {
                                    detailedBookingVM.getTimesForSelectedDates(selectedDate: date)
                                }
                            }
                        }
                    }
                }
                
                Text("Choose a Time")
                if !detailedBookingVM.timeDisplay.isEmpty {
                    ScrollView (.horizontal) {
                        HStack (spacing: 5) {
                            ForEach (detailedBookingVM.timeDisplay, id: \.self) {time in
                                Text(Helpers.getSimpleTimeForAppointment(timeStamp1: time))
                                    .padding(8)
                                    .background(detailedBookingVM.selectedTime == time ? Color.blue.opacity(0.2) : Color.white)
                                    .cornerRadius(5)
                                    .shadow(radius: 2)
                                    .padding(.vertical, 7)
                                    .padding(.horizontal, 5)
                                    .onTapGesture {
                                        detailedBookingVM.selectTime(time: time)
                                    }
                            }
                        }
                    }
                }
                
                LargeButton(title: "Book Appointment",
                            backgroundColor: Color.blue) {
                    self.detailedBookingVM.book() { success in
                        if success {
                            CustomerAlertHelpers().AppointmentBookedAlert(timeStamp: self.detailedBookingVM.selectedTime) { (done) in
                                CommonDefaultModifiers.showLoader()
                                CustomerDefaultModifiers.navigateToDetailedView()
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .environmentObject(self.detailedBookingVM.reasonVM)
        
    }

    var header : some View {
        VStack (alignment: .leading) {
            
            HStack (alignment: .center) {
                
                if detailedBookingVM.docProfPicImageLoader != nil {
                    ImageView(imageLoader: detailedBookingVM.docProfPicImageLoader!, height: 100, width: 100)
                }
                
                VStack (alignment: .leading, spacing: 8) {
                    
                    HStack {
                        Text(detailedBookingVM.serviceProviderName)
                            .font(.system(size: 16))
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
                Spacer()
            }
            .padding(.top, 10)
        }
    }
}
