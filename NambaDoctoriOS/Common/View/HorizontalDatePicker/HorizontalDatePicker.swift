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
                
                HStack {
                    Text(self.datePickerVM.datePickerTitle)
                        .foregroundColor(.black.opacity(0.7))
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)

                ScrollViewReader { scrollview in
                    ScrollView (.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach (0..<datePickerVM.datesCount) { index in
                                ZStack {
                                    VStack {
                                        Text(datePickerVM.getDateLetter(index: index))
                                            .foregroundColor(datePickerVM.compareDate(index: index) ? Color.white : Color.black.opacity(0.7))
                                            .bold()
                                            .padding(.bottom, 5)
                                        Text(datePickerVM.getDateNumber(index: index))
                                            .foregroundColor(datePickerVM.compareDate(index: index) ? Color.white : Color.black.opacity(0.7))
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
                                .frame(width: 36, height: 65)
                                .id(index)
                                .padding()
                                .background(datePickerVM.compareDate(index: index) ? Color(CustomColors.SkyBlue) : Color.white)
                                .cornerRadius(15)
                                .onTapGesture {
                                    datePickerVM.selectDate(index: index)
                                }
                                .onAppear() {
                                    datePickerVM.setTitle(date: datePickerVM.Dates[index].date)
                                }
                            }
                        }.frame(height: 100)
                    }.onAppear() {scrollview.scrollTo(datePickerVM.index, anchor: .center)}
                }
            }
        }
        .padding([.top, .bottom])
    }

}
