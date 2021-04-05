//
//  HorizontalDatePicker.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/03/21.
//

import SwiftUI

struct HorizontalDatePicker: View {
    
    @ObservedObject var datePickerVM:DatePickerViewModel
    
    var body: some View {
        VStack {
            if datePickerVM.showScrollView {
                
                if Helpers.compareDate(date1: datePickerVM.todayDate, date2: datePickerVM.selectedDate) {
                    Text("Today")
                        .foregroundColor(.black)
                        .bold()
                } else {
                    Text("\(Helpers.getDisplayForDateSelector(date: datePickerVM.selectedDate))")
                        .foregroundColor(.black)
                        .bold()
                }

                ScrollViewReader { scrollview in
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach (0..<datePickerVM.datesCount) { index in
                                ZStack {
                                    VStack {
                                        Text(datePickerVM.getDateLetter(index: index))
                                            .foregroundColor(datePickerVM.compareDate(index: index) ? Color.white : Color.black)
                                            .bold()
                                            .padding(.bottom, 5)
                                        Text(datePickerVM.getDateNumber(index: index))
                                            .foregroundColor(datePickerVM.compareDate(index: index) ? Color.white : Color.black)
                                            .bold()
                                    }

                                    if datePickerVM.ifHasAppointment(index: index) && !datePickerVM.compareDate(index: index) {
                                        VStack {
                                            Spacer()
                                            Image("circle.fill")
                                                .frame(width: 1, height: 1)
                                                .foregroundColor(datePickerVM.ifIsUpcoming(index: index) ? .blue : .gray)
                                        }
                                    }
                                    
                                }
                                .frame(height: 70)
                                .id(index)
                                .padding()
                                .background(datePickerVM.compareDate(index: index) ? Color.black : Color.white)
                                .cornerRadius(50)
                                .onTapGesture {
                                    datePickerVM.selectDate(index: index)
                                }
                            }
                        }
                    }.onAppear() {
                        scrollview.scrollTo(datePickerVM.index, anchor: .center)
                    }
                }
            }
        }
        .padding([.top, .bottom])
    }

}
