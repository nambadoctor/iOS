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
    
    @Published var newChats:Int = 0

    init(appointment:CustomerAppointment,
         delegate:CustomerSelectAppointmentDelegate) {
        self.appointment = appointment
        self.delegate = delegate
        
        newChatListener()
        getNewChatCount()
    }
     
    var appointmentStatus:String {
        if appointment.status == ConsultStateK.Confirmed.rawValue {
            return "Appointment Upcoming"
        } else if appointment.status == ConsultStateK.StartedConsultation.rawValue {
            return "In-Progress"
        } else {
            if appointment.isPaid {
                return "Click to view prescription"
            } else {
                return "Payment Pending"
            }
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
    
    func getNewChatCount () {
        self.newChats = LocalNotifStorer().getNumberOfNewChatsForAppointment(appointmentId: self.appointment.appointmentID)
    }

    func newChatListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(SimpleStateK.refreshNewChatCountChange)"), object: nil, queue: .main) { (_) in
            self.getNewChatCount()
        }
    }
}

