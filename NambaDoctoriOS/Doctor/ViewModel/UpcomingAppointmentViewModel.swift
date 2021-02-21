//
//  AppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation
import SwiftUI

class UpcomingAppointmentViewModel: ObservableObject {
    @Published var appointment:Appointment

    @Published var consultationStarted:Bool = false
    @Published var consultationDone:Bool = false

    @Published var takeToTwilioRoom:Bool = false
    @Published var takeToWritePrescription:Bool = false
    @Published var takeToViewPatientInfo:Bool = false

    @Published var showCancelButton:Bool = false

    private var patientTokenId:String = ""
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()

    private var updateAppointmentStatus:UpdateAppointmentStatusProtocol
    private var doctorAlertHelper:DoctorAlertHelpersProtocol

    init(appointment:Appointment,
         updateAppointmentStatus:UpdateAppointmentStatusProtocol = UpdateAppointmentStatusViewModel(),
         doctorAlertHelper:DoctorAlertHelpersProtocol = DoctorAlertHelpers()) {
        
        self.appointment = appointment
        self.updateAppointmentStatus = updateAppointmentStatus
        self.doctorAlertHelper = doctorAlertHelper
        checkIfConsultationStarted()
        checkToShowCancelButton()
        checkIfConsultationDone()
    }

    var LocalTime:String {
        return Helpers.getTimeFromTimeStamp(timeStamp: self.appointment.requestedTime)
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

    func checkToShowCancelButton() {
        if appointment.status == ConsultStateK.Confirmed.rawValue {
            self.showCancelButton = true
        }
    }
    
    func cancelAppointment() {
        doctorAlertHelper.cancelAppointmentAlert { (cancel) in
            self.updateAppointmentStatus.toCancelled(appointment: &self.appointment) { (success) in
                if success {
                    DocNotifHelpers.sharedNotifHelpers.fireCancelNotif(requestedBy: self.appointment.requestedBy, appointmentTime: self.appointment.requestedTime)
                    DoctorDefaultModifiers.refreshAppointments()
                    self.checkToShowCancelButton()
                } else {
                    GlobalPopupHelpers.setErrorAlert()
                }
            }
        }
    }

    func startConsultation() {
        self.takeToTwilioRoom = true
    }

    func writePrescription() {
        consultationDone = true
        doctorAlertHelper.writePrescriptionAlert(appointmentId: appointmentId, requestedBy: appointment.requestedBy) { (navigate) in
            self.takeToWritePrescription = true

            self.updateAppointmentStatus.updateToFinishedAppointment(appointment: &self.appointment)
                { _ in }

            DocNotifHelpers.sharedNotifHelpers.fireAppointmentOverNotif(requestedBy: self.appointment.requestedBy)

        }
    }

    func viewPatientInfo() {
        docSheetHelper.showPatientInfoSheet(appointment: appointment)
    }
}
