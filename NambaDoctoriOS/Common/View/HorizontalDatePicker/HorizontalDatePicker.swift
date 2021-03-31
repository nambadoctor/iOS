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
                                VStack {
                                    Text(datePickerVM.getDateLetter(index: index))
                                        .foregroundColor(datePickerVM.compareDate(index: index) ? Color.white : Color.black)
                                        .bold()
                                        .padding(.bottom, 5)
                                    Text(datePickerVM.getDateNumber(index: index))
                                        .foregroundColor(datePickerVM.compareDate(index: index) ? Color.white : Color.black)
                                        .bold()
                                }.id(index)
                                .padding()
                                .background(datePickerVM.compareDate(index: index) ? Color.black : Color.white)
                                .cornerRadius(50)
                                .onTapGesture {
                                    datePickerVM.selectDate(index: index)
                                }
                            }
                        }
                    }.onAppear() {scrollview.scrollTo(datePickerVM.index, anchor: .center)}
                }
            }
        }
        .padding([.top, .bottom])
        .onAppear() {
            datePickerVM.setArrayOfDatesToSelect()
        }
    }

}
