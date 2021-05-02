//
//  CustomerAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/28/21.
//

import Foundation

class CustomerAppointmentViewModel : ObservableObject {
    var appointment:CustomerAppointment
    
    @Published var takeToDetailedAppointmentView:Bool = false
    
    init(appointment:CustomerAppointment) {
        self.appointment = appointment
    }
    
    var appointmentStatus:String {
        if appointment.status == ConsultStateK.Confirmed.rawValue {
            return "Appointment Upcoming"
        } else if appointment.status == ConsultStateK.StartedConsultation.rawValue {
            return "In-Progress"
        } else {
            return "Please wait for prescription"
        }
    }

    var startDateMonth:String {
        return Helpers.load3LetterMonthName(timeStamp: appointment.scheduledAppointmentStartTime)
    }
    
    var startDate:String {
        return Helpers.loadDate(timeStamp: appointment.scheduledAppointmentStartTime)
    }
    
    func takeToDetailedView () {
        self.takeToDetailedAppointmentView = true
    }
    
    func makeDetailedAppointmentVM() -> CustomerDetailedAppointmentViewModel {
        return CustomerDetailedAppointmentViewModel(appointment: self.appointment)
    }
}

