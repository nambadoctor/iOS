//
//  DatePickerViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 26/03/21.
//

import Foundation
import SwiftUI

protocol DatePickerChangedDelegate {
    func dateChanged(selectedDate:Date)
}

struct CustomDate : Identifiable {
    var id:String = UUID().uuidString
    var date:Date
    var hasAppointment:Bool
    var isUpcoming:Bool
}

class DatePickerViewModel : ObservableObject {
    let calendar = Calendar.current
    var startDate:Date = Calendar.current.date(byAdding: DateComponents(year: -1), to: Date())!
    var endDate:Date = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
    var todayDate:Date = Date()

    @Published var Dates:[CustomDate] = [CustomDate]()
    @Published var selectedDate:Date = Date()
    @Published var index = 20
    @Published var showScrollView : Bool = false
    
    @Published var datePickerTitle:String = ""

    var datePickerDelegate:DatePickerChangedDelegate? = nil
    
    init() {
        setArrayOfDatesToSelect()
    }

    var datesCount:Int {
        return Dates.count
    }

    func ifHasAppointment (index:Int) -> Bool {
        return Dates[index].hasAppointment
    }
    
    func ifIsUpcoming (index:Int) -> Bool {
        return Dates[index].isUpcoming
    }
    
    func getDateLetter (index:Int) -> String {
        return Helpers.getDatePickerStringFromDate(date: Dates[index].date)[0]
    }
    
    func getDateNumber (index:Int) -> String {
        Helpers.getDatePickerStringFromDate(date: Dates[index].date)[1]
    }

    func compareDate (index:Int) -> Bool {
        return Helpers.compareDate(date1: Dates[index].date, date2: selectedDate)
    }

    func selectDate (index:Int) {
        self.index = index
        selectedDate = Dates[index].date
        datePickerDelegate?.dateChanged(selectedDate: selectedDate)
    }
    
    func selectTodayDate () {
        selectedDate = Date()
        setTodaysDateIndex()
        datePickerDelegate?.dateChanged(selectedDate: selectedDate)
    }
    
    func setDatesWithAppointments (appointments:[ServiceProviderAppointment]) {
        
        func clearAllAppointmentVals () {
            for i in Dates.indices {
                Dates[i].hasAppointment = false
            }
        }

        clearAllAppointmentVals()

        var upcomingAppointmentDates:[String] = [String]()
        var previousAppointmentDates:[String] = [String]()

        for appoinment in appointments {
            let dateString = Helpers.MonthDayDateString(date: Date(milliseconds: appoinment.scheduledAppointmentStartTime))
            if (appoinment.status == "Confirmed" || appoinment.status == "StartedConsultation") && !upcomingAppointmentDates.contains(dateString) {
                upcomingAppointmentDates.append(dateString)
            } else if (appoinment.status != "Confirmed" && appoinment.status != "StartedConsultation") && !previousAppointmentDates.contains(dateString) {
                previousAppointmentDates.append(dateString)
            }
        }

        for i in Dates.indices {
            let currentDateString = Helpers.MonthDayDateString(date: Dates[i].date)
            if upcomingAppointmentDates.contains(currentDateString) {
                Dates[i].hasAppointment = true
                Dates[i].isUpcoming = true
            }
            
            if previousAppointmentDates.contains(currentDateString) {
                Dates[i].hasAppointment = true
            }
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

            let dateObject = CustomDate(date: date, hasAppointment: false, isUpcoming: false)
            Dates.append(dateObject)
        }

        setTodaysDateIndex()

        self.showScrollView = true
        datePickerDelegate?.dateChanged(selectedDate: selectedDate)
        self.setTitle(date: selectedDate)
    }
    
    func setTodaysDateIndex () {
        for localIndex in Dates.indices {
            var dateObj = Dates[localIndex]
            let order = Calendar.current.compare(dateObj.date, to: todayDate, toGranularity: .day)

            if order == .orderedSame {
                index = localIndex
            }
        }
    }
    
    func setTitle (date:Date) {
        self.datePickerTitle = Helpers.MonthYearDateString(date: date)
    }
}
