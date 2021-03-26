//
//  DatePickerViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 26/03/21.
//

import Foundation

protocol DatePickerChangedDelegate {
    func dateChanged(selectedDate:Date)
}

class DatePickerViewModel : ObservableObject {
    let calendar = Calendar.current
    var startDate:Date = Calendar.current.date(byAdding: DateComponents(day: -30), to: Date())!
    var endDate:Date = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
    var todayDate:Date = Date()
    
    @Published var Dates:[Date] = [Date]()
    @Published var selectedDate:Date = Date()
    @Published var index = 20
    @Published var showScrollView : Bool = false
    
    var datePickerDelegate:DatePickerChangedDelegate? = nil
    
    var datesCount:Int {
        return Dates.count
    }
    
    func getDateLetter (index:Int) -> String {
        return Helpers.getDatePickerStringFromDate(date: Dates[index])[0]
    }
    
    func getDateNumber (index:Int) -> String {
        Helpers.getDatePickerStringFromDate(date: Dates[index])[1]
    }
    
    func compareDate (index:Int) -> Bool {
        return Helpers.compareDate(date1: Dates[index], date2: selectedDate)
    }
    
    func selectDate (index:Int) {
        selectedDate = Dates[index]
        datePickerDelegate?.dateChanged(selectedDate: selectedDate)
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
        datePickerDelegate?.dateChanged(selectedDate: selectedDate)
    }
}
