//
//  AppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation
import SwiftUI

protocol SelectAppointmentDelegate {
    func selectedAppointment(appointment:ServiceProviderAppointment)
}

class AppointmentViewModel: ObservableObject {
    @Published var appointment:ServiceProviderAppointment
    
    @Published var consultationStarted:Bool = false
    @Published var consultationFinished:Bool = false
    
    @Published var newChats:Int = 0
    
    var selectedAppointmentDelegate:SelectAppointmentDelegate? = nil

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
        getNewChatCount()
        newChatListener()
    }

    var LocalTime:String {
        return Helpers.getTimeFromTimeStamp(timeStamp: self.appointment.scheduledAppointmentStartTime)
    }

    var appointmentId:String {
        return self.appointment.appointmentID
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
    
    func getLetterColor() -> Color {
        if appointment.status == ConsultStateK.StartedConsultation.rawValue {
            return .green
        } else if appointment.status == ConsultStateK.Finished.rawValue ||
                    appointment.status == ConsultStateK.FinishedAppointment.rawValue {
            return .gray
        } else {
            return .blue
        }
    }
    
    func onCardClicked () {
        self.selectedAppointmentDelegate?.selectedAppointment(appointment: self.appointment)
    }

    func getAppointmentTime () -> String {
        return Helpers.getSimpleTimeForAppointment(timeStamp1: appointment.scheduledAppointmentStartTime)
    }
    
    func getAppointmentTimeSpan () -> String {
        return Helpers.getSimpleTimeSpanForAppointment(timeStamp1: appointment.scheduledAppointmentStartTime, timeStamp2: appointment.scheduledAppointmentEndTime)
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
