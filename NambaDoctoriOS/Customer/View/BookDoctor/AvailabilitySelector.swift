//
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
            Text("Choose a Date")
            if !availabilitySelectorVM.dateDisplay.isEmpty {
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
                                availabilitySelectorVM.getTimesForSelectedDates(selectedDate: date)
                            }
                        }
                    }
                }
            } else {
                Text("Oops no dates available")
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
