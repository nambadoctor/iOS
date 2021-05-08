//
//  CustomerAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/28/21.
//

import Foundation

protocol CustomerSelectAppointmentDelegate {
    func selected(appointment:CustomerAppointment)
}

class CustomerAppointmentViewModel : ObservableObject {
    var appointment:CustomerAppointment
    var delegate:CustomerSelectAppointmentDelegate
    
    init(appointment:CustomerAppointment,
         delegate:CustomerSelectAppointmentDelegate) {
        self.appointment = appointment
        self.delegate = delegate
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
        self.delegate.selected(appointment: self.appointment)
    }
}

