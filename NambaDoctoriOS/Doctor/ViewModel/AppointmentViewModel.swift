//
//  AppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation
import SwiftUI

class AppointmentViewModel: ObservableObject {
    @Published var appointment:ServiceProviderAppointment

    @Published var takeToTwilioRoom:Bool = false
    @Published var takeToDetailedAppointment:Bool = false
    
    @Published var consultationStarted:Bool = false
    @Published var consultationFinished:Bool = false

    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()
    private var docNotifHelper:DocNotifHelpers

    private var doctorAlertHelper:DoctorAlertHelpersProtocol

    init(appointment:ServiceProviderAppointment,
         doctorAlertHelper:DoctorAlertHelpersProtocol = DoctorAlertHelpers()) {
        
        self.appointment = appointment
        self.doctorAlertHelper = doctorAlertHelper
        self.docNotifHelper = DocNotifHelpers(appointment: appointment)
        checkIfAppointmentStarted()
        checkIfAppointmentFinished()
    }
    
    var firstLetterOfCustomer : String {
        return appointment.customerName[0]
    }

    var LocalTime:String {
        return Helpers.getTimeFromTimeStamp(timeStamp: self.appointment.scheduledAppointmentStartTime)
    }

    var appointmentId:String {
        return self.appointment.appointmentID
    }
    
    var paymentStatus:String {
        if self.appointment.isPaid {
            return "Paid"
        } else {
            return "Payment Pending"
        }
    }

    func checkIfAppointmentStarted () {
        if appointment.status == ConsultStateK.StartedConsultation.rawValue
        {
            self.consultationStarted = true
        }
    }
    
    func checkIfAppointmentFinished() {
        if appointment.status == ConsultStateK.Finished.rawValue ||
                    appointment.status == ConsultStateK.FinishedAppointment.rawValue
        {
            self.consultationFinished = true
        }
    }

    func navigateIntoAppointment () {
        self.takeToDetailedAppointment = true
    }

    func startConsultation() {
        self.takeToTwilioRoom = true
    }
    
    func getAppointmentTime () -> String {
        return Helpers.getSimpleTimeForAppointment(timeStamp1: appointment.scheduledAppointmentStartTime)
    }
    
    func getAppointmentTimeSpan () -> String {
        return Helpers.getSimpleTimeSpanForAppointment(timeStamp1: appointment.scheduledAppointmentStartTime, timeStamp2: appointment.scheduledAppointmentEndTime)
    }
}
