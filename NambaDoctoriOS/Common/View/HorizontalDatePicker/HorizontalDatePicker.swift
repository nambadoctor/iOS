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
                ScrollViewReader { scrollview in
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach (0..<datePickerVM.datesCount) { index in
                                VStack {
                                    Text(datePickerVM.getDateLetter(index: index))
                                    Text(datePickerVM.getDateNumber(index: index))
                                }.id(index)
                                .padding()
                                .background(datePickerVM.compareDate(index: index) ? Color.gray : Color.white)
                                .cornerRadius(50)
                                .onTapGesture {
                                    datePickerVM.selectDate(index: index)
                                }
                            }
                        }
                    }.onAppear() {scrollview.scrollTo(datePickerVM.index, anchor: .center)}
                }
            }
        }.onAppear() {
            datePickerVM.setArrayOfDatesToSelect()
        }
    }

}
