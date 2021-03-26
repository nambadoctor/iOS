//
//  HorizontalDatePicker.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/03/21.
//

import SwiftUI

struct HorizontalDatePicker: View {
    
    let calendar = Calendar.current
    var startDate:Date = Calendar.current.date(byAdding: DateComponents(day: -30), to: Date())!
    var endDate:Date = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
    @State var Dates:[Date] = [Date]()
    @State var selectedDate:Date = Date()
    var todayDate:Date = Date()
    @State var index = 20
    
    @State var showScrollView : Bool = false
    
    var body: some View {
        VStack {
            if showScrollView {
                ScrollViewReader { scrollview in
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach (0..<Dates.count) { index in
                                VStack {
                                    Text(Helpers.getDatePickerStringFromDate(date: Dates[index])[0])
                                    Text(Helpers.getDatePickerStringFromDate(date: Dates[index])[1])
                                }.id(Dates.firstIndex(of: Dates[index]))
                                .padding()
                                .background(Helpers.compareDate(date1: Dates[index], date2: selectedDate) ? Color.gray : Color.white)
                                .cornerRadius(50)
                                .onTapGesture {
                                    selectedDate = Dates[index]
                                }
                            }
                        }
                    }.onAppear() {scrollview.scrollTo(index, anchor: .center)}
                }
            }
        }.onAppear() {
            setArrayOfDatesToSelect()
        }
    }
    
    func setArrayOfDatesToSelect() {
        calendar.enumerateDates(startingAfter: startDate,
                                matching: DateComponents(hour: 0, minute: 0, second:0),
                                matchingPolicy: .nextTime) { (date, _, stop) in
            guard let date = date, date < endDate else {
                stop = true
                return
            }
            
            Dates.append(date)
        }
        
        var localIndex = 0
        for date in Dates {
            let order = Calendar.current.compare(date, to: todayDate, toGranularity: .day)

            if order == .orderedSame {
                index = localIndex
            }
            
            localIndex+=1
        }
        
        self.showScrollView = true
    }
}
