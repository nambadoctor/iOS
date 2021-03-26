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

    @Published var consultationStarted:Bool = false
    @Published var consultationDone:Bool = false

    @Published var takeToTwilioRoom:Bool = false
    @Published var takeToDetailedAppointment:Bool = false
            
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()
    private var docNotifHelper:DocNotifHelpers

    private var updateAppointmentStatus:UpdateAppointmentStatusProtocol
    private var doctorAlertHelper:DoctorAlertHelpersProtocol

    init(appointment:ServiceProviderAppointment,
         updateAppointmentStatus:UpdateAppointmentStatusProtocol = UpdateAppointmentStatusHelper(),
         doctorAlertHelper:DoctorAlertHelpersProtocol = DoctorAlertHelpers()) {
        
        self.appointment = appointment
        self.updateAppointmentStatus = updateAppointmentStatus
        self.doctorAlertHelper = doctorAlertHelper
        self.docNotifHelper = DocNotifHelpers(appointment: appointment)
        checkIfConsultationStarted()
        checkIfConsultationDone()
    }

    var LocalTime:String {
        return Helpers.getTimeFromTimeStamp(timeStamp: self.appointment.scheduledAppointmentStartTime)
    }

    var appointmentId:String {
        return self.appointment.appointmentID
    }

    var cardBackgroundColor:Color {
        return appointment.status == ConsultStateK.StartedConsultation.rawValue ? Color(UIColor.green).opacity(0.5) : Color.white
    }

    func checkIfConsultationStarted() {
        if appointment.status == ConsultStateK.StartedConsultation.rawValue {
            consultationStarted = true
        }
    }
    
    func checkIfConsultationDone() {
        if appointment.status == ConsultStateK.FinishedAppointment.rawValue {
            consultationDone = true
        }
    }

    func navigateIntoAppointment () {
        self.takeToDetailedAppointment = true
    }

    func startConsultation() {
        self.takeToTwilioRoom = true
    }
    
    func getAppointmentTimeSpan () -> String {
        return Helpers.getSimpleTimeForAppointment(timeStamp1: appointment.scheduledAppointmentStartTime, timeStamp2: appointment.scheduledAppointmentEndTime)
    }
}
