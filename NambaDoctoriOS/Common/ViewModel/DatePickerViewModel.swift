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

struct CustomDate : Identifiable {
    var id:String = UUID().uuidString
    var date:Date
    var hasAppointment:Bool
    var isUpcoming:Bool
}

class DatePickerViewModel : ObservableObject {
    let calendar = Calendar.current
    var startDate:Date = Calendar.current.date(byAdding: DateComponents(day: -30), to: Date())!
    var endDate:Date = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
    var todayDate:Date = Date()
        
    @Published var Dates:[CustomDate] = [CustomDate]()
    @Published var selectedDate:Date = Date()
    @Published var index = 20
    @Published var showScrollView : Bool = false
    
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
        selectedDate = Dates[index].date
        datePickerDelegate?.dateChanged(selectedDate: selectedDate)
    }
    
    func setDatesWithAppointments (appointments:[ServiceProviderAppointment]) {

        var upcomingAppointmentDates:[String] = [String]()
        var previousAppointmentDates:[String] = [String]()
        
        for appoinment in appointments {
            var dateString = Helpers.getDisplayForDateSelector(date: Date(milliseconds: appoinment.scheduledAppointmentStartTime))
            if appoinment.status == "Confirmed" && !upcomingAppointmentDates.contains(dateString) {
                upcomingAppointmentDates.append(dateString)
            } else if appoinment.status != "Confirmed" && !previousAppointmentDates.contains(dateString) {
                previousAppointmentDates.append(dateString)
            }
        }

        var index = 0
        for date in Dates {
            var currentDateString = Helpers.getDisplayForDateSelector(date: date.date)
            if upcomingAppointmentDates.contains(currentDateString) {
                Dates[index].hasAppointment = true
                Dates[index].isUpcoming = true
            }
            
            if previousAppointmentDates.contains(currentDateString) {
                Dates[index].hasAppointment = true
            }
            
            index+=1
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

        var localIndex = 0
        for dateObj in Dates {
            let order = Calendar.current.compare(dateObj.date, to: todayDate, toGranularity: .day)

            if order == .orderedSame {
                index = localIndex
            }

            localIndex+=1
        }

        self.showScrollView = true
        datePickerDelegate?.dateChanged(selectedDate: selectedDate)
    }
}
