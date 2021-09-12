//  AvailabilitySelector.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/24/21.
//

import SwiftUI

struct AvailabilitySelector : View {
    @Environment(\.openURL) var openURL
    @ObservedObject var availabilitySelectorVM:AvailabilitySelectorViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            
            if self.availabilitySelectorVM.noAvailabilities {
                HStack {
                    Spacer()
                    VStack (alignment: .center) {
                        Text("Sorry doctor is not available")
                            .foregroundColor(.blue)
                            .bold()
                            .padding(.bottom)
                        
                        Button {
                            openWhatsapp(phoneNumber: "+917530043008", textToSend: "Hello, I need to book for this doctor but there is no availability")
                        } label: {
                            Text("Contact Support")
                                .foregroundColor(.white)
                        }
                        .padding(10)
                        .background(Color.red)
                        .cornerRadius(7)
                    }
                    Spacer()
                }
                .modifier(DetailedAppointmentViewCardModifier())
            } else if !self.availabilitySelectorVM.selectedSlotOption {
                VStack {
                    Text("How would you like to see the doctor?")
                    
                    LargeButton(title: self.availabilitySelectorVM.noOnlineSlots ? "Online (Unavailable)" : "Online",
                                backgroundColor: self.availabilitySelectorVM.noOnlineSlots ? .gray : .blue) {
                        self.availabilitySelectorVM.getOnlyOnlineSlots()
                    }
                    
                    LargeButton(title: self.availabilitySelectorVM.noInPersonSlots ? "In-Person (Unavailable)" : "In-Person",
                                backgroundColor: self.availabilitySelectorVM.noInPersonSlots ? .gray : .blue) {
                        self.availabilitySelectorVM.getAllAddresses { success, error in
                            if success {
                                self.availabilitySelectorVM.getOnlyInPersonSlots()
                            }

                            if error {
                                
                            }
                        }
                    }
                }
                .modifier(DetailedAppointmentViewCardModifier())
            } else if self.availabilitySelectorVM.showSelectAddressView {
                VStack (alignment: .leading) {
                    Text("Please select your preferred location")
                    ScrollView {
                        ForEach(self.availabilitySelectorVM.addresses, id: \.addressID) { address in
                            Button {
                                self.availabilitySelectorVM.selectAddress(address: address)
                            } label: {
                                if self.availabilitySelectorVM.getOrganisationFromAddressId(addressId: address.addressID) != nil {
                                    VStack {
                                        HStack {
                                            ImageView(imageLoader: ImageLoader(urlString: self.availabilitySelectorVM.getOrganisationFromAddressId(addressId: address.addressID)!.logo, { _ in }))
                                            VStack {
                                                Text(self.availabilitySelectorVM.getOrganisationFromAddressId(addressId: address.addressID)!.name)
                                                Text(address.streetAddress)
                                                    .font(.headline)
                                            }
                                            Spacer()
                                        }
                                        Divider()
                                    }
                                }
                            }
                            .padding(5)
                        }
                    }
                }
                .modifier(DetailedAppointmentViewCardModifier())
            } else {
                slotPickerView
            }
        }
    }
    
    var slotPickerView : some View {
        VStack (alignment: .leading) {

//            SideBySideCheckBox(isChecked: self.$availabilitySelectorVM.showOnlineOrOfflineSlots, title1: "Show Online Availability", title2: "Show In-Person Availability", delegate: self.availabilitySelectorVM)
       
            VStack (alignment: .leading) {
                HStack {Spacer()}
                HStack {
                    if self.availabilitySelectorVM.showOnlineOrOfflineSlots == "Show Online Availability" {
                        HStack {
                            Text("Appointment Type:")
                            Text("Online").bold()
                        }
                        
                    } else if self.availabilitySelectorVM.showOnlineOrOfflineSlots == "Show In-Person Availability" {
                        HStack {
                            Text("Appointment Type:")
                            Text("In-Person").bold()
                        }
                    }
                }.padding(.vertical, 2)
                
                if self.availabilitySelectorVM.selectedAddress != nil {
                    HStack {
                        Text("Location:")
                        Text(self.availabilitySelectorVM.selectedAddress!.streetAddress).bold().underline().foregroundColor(.blue)
                            .onTapGesture () {
                                openURL(URL(string: self.availabilitySelectorVM.selectedAddress!.googleMapsAddress)!)
                            }
                        //addressPicker
                    }.padding(.vertical, 2)
                }
            }.modifier(DetailedAppointmentViewCardModifier())
            
            VStack (alignment: .leading) {
                if self.availabilitySelectorVM.noOnlineSlots {
                    Text("Sorry this doctor has no online slots available")
                } else if self.availabilitySelectorVM.noInPersonSlots {
                    Text("Sorry this doctor has no in person slots available")
                } else {
                    if !availabilitySelectorVM.dateDisplay.isEmpty {
                        Text("Choose a Date")
                        
                        ScrollView (.horizontal) {
                            HStack (spacing: 5) {
                                ForEach (availabilitySelectorVM.dateDisplay, id: \.self) {date in
                                    VStack (spacing: 5) {
                                        Text(Helpers.load3LetterDayName(timeStamp: date))
                                        Text("\(Helpers.loadDate(timeStamp: date)) \(Helpers.load3LetterMonthName(timeStamp: date))")
                                    }
                                    .padding(8)
                                    .background(availabilitySelectorVM.selectedDate == date ? Color.blue.opacity(0.2) : Color.white)
                                    .cornerRadius(5)
                                    .shadow(radius: 2)
                                    .padding(.vertical, 7)
                                    .padding(.horizontal, 5)
                                    .onTapGesture {
                                        availabilitySelectorVM.getTimesForSelectedDates(selectedDate: date, slots: self.availabilitySelectorVM.slots!)
                                    }
                                }
                            }
                        }
                    } else {
                        if self.availabilitySelectorVM.noAvailabilities {
                            Text("Oops no dates available")
                        } else {
                            Indicator()
                        }
                    }
                    
                    if !availabilitySelectorVM.timeDisplay.isEmpty {
                        Text("Choose a Time")
                        ScrollView (.horizontal) {
                            HStack (spacing: 5) {
                                ForEach (availabilitySelectorVM.timeDisplay, id: \.self) {time in
                                    VStack {
                                        Text(Helpers.getSimpleTimeForAppointment(timeStamp1: time))
                                        if availabilitySelectorVM.getFeeForTimeSlot(time: time) != nil {
                                            Text("₹\(availabilitySelectorVM.getFeeForTimeSlot(time: time)!.clean)")
                                                .foregroundColor(.green)
                                                .font(.subheadline)
                                        }
                                    }
                                    .padding(8)
                                    .background(availabilitySelectorVM.selectedTime == time ? Color.blue.opacity(0.2) : Color.white)
                                    .cornerRadius(5)
                                    .shadow(radius: 2)
                                    .padding(.vertical, 7)
                                    .padding(.horizontal, 5)
                                    .onTapGesture {
                                        availabilitySelectorVM.selectTime(time: time)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .modifier(DetailedAppointmentViewCardModifier())
        }
    }
    
    var addressPicker : some View {
        Menu {
            ForEach(self.availabilitySelectorVM.addresses, id: \.addressID) {address in
                Button {
                    self.availabilitySelectorVM.selectAddress(address: address)
                } label: {
                    Text(address.streetAddress)
                }
            }
        } label: {
            Text(self.availabilitySelectorVM.selectedAddress!.streetAddress)
            Image("chevron.down.circle")
        }
    }
}
