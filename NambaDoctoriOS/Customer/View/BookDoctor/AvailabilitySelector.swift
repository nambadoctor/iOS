//  AvailabilitySelector.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/24/21.
//

import SwiftUI

struct AvailabilitySelector : View {
    
    @ObservedObject var availabilitySelectorVM:AvailabilitySelectorViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            
            if !self.availabilitySelectorVM.selectedSlotOption {
                VStack {
                    Text("How would you like to see the doctor?")
                    
                    LargeButton(title: "Online") {
                        self.availabilitySelectorVM.getOnlyOnlineSlots()
                    }
                    
                    LargeButton(title: "In Person") {
                        self.availabilitySelectorVM.getOnlyInPersonSlots()
                    }
                }
            } else {
                slotPickerView
            }
        }
        .padding()
    }
    
    var slotPickerView : some View {
        VStack (alignment: .leading) {
            
            SideBySideCheckBox(isChecked: self.$availabilitySelectorVM.showOnlineOrOfflineSlots, title1: "Show Online Availability", title2: "Show In-Person Availability", delegate: self.availabilitySelectorVM)
            
            if self.availabilitySelectorVM.noOnlineSlots && self.availabilitySelectorVM.noInPersonSlots {
                Text("Sorry doctor is not available")
            } else if self.availabilitySelectorVM.noOnlineSlots {
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
                                Text(Helpers.getSimpleTimeForAppointment(timeStamp1: time))
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
    }
}
