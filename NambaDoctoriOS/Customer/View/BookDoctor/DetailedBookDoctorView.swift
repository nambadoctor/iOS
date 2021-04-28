//
//  DetailedBookDoctorView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import SwiftUI

struct DetailedBookDoctorView: View {
    
    @ObservedObject var detailedBookingVM:DetailedBookDocViewModel
    
    var body: some View {
        ScrollView {
            
            Text("Reason For Appointment")
            ExpandingTextView(text: self.$detailedBookingVM.reasonForAppointment)

            Text("Choose a Date")
            
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
                            .padding()
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
                                .padding()
                                .onTapGesture {
                                    detailedBookingVM.selectTime(time: time)
                                }
                        }
                    }
                }
            }
            
            LargeButton(title: "Book Appointment",
                        backgroundColor: Color.blue) {
                self.detailedBookingVM.book()
            }
        }
    }
}
