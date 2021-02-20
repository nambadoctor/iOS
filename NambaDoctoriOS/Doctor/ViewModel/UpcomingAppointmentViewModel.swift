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
    private var notifHelper:DocNotifHelpersProtocol
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()

    private var updateAppointmentStatus:UpdateAppointmentStatusProtocol
    private var doctorAlertHelper:DoctorAlertHelpersProtocol
    private var twilioAccessTokenHelper:TwilioAccessTokenProtocol

    init(appointment:Appointment,
         updateAppointmentStatus:UpdateAppointmentStatusProtocol = UpdateAppointmentStatusViewModel(),
         doctorAlertHelper:DoctorAlertHelpersProtocol = DoctorAlertHelpers(),
         twilioAccessTokenHelper:TwilioAccessTokenProtocol = RetrieveTwilioAccessToken(),
         notifHelper:DocNotifHelpersProtocol = DocNotifHelpers()) {
        
        self.appointment = appointment
        self.updateAppointmentStatus = updateAppointmentStatus
        self.twilioAccessTokenHelper = twilioAccessTokenHelper
        self.doctorAlertHelper = doctorAlertHelper
        self.notifHelper = notifHelper
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
        updateAppointmentStatus.toCancelled(appointment: &appointment) { (success) in
            if success {
                self.getPatientFCMTokenId { _ in
                    self.notifHelper.fireCancelNotif(patientToken: self.patientTokenId, appointmentTime: self.appointment.createdDateTime)
                }
                DoctorDefaultModifiers.refreshAppointments()
                self.checkToShowCancelButton()
            } else {
                GlobalPopupHelpers.setErrorAlert()
            }
        }
    }

    func startConsultation() {
        twilioAccessTokenHelper.retrieveToken(appointmentId: appointmentId) { (success, token) in
            if success {
                self.updateAppointmentStatus.updateToStartedConsultation(appointment: &self.appointment) { (success) in
                    if success {
                        TwilioAlertHelpers.TwilioRoomHideLoadingAlert()
                        self.takeToTwilioRoom = true
                        self.getPatientFCMTokenId { _ in
                            self.notifHelper.fireStartedConsultationNotif(patientToken: self.patientTokenId, appointmentTime: self.appointment.createdDateTime)
                        }
                    }
                }
            } else {
                //show failed alert
            }
        }
    }

    func writePrescription() {
        consultationDone = true
        doctorAlertHelper.writePrescriptionAlert(appointmentId: appointmentId, requestedBy: appointment.requestedBy) { (navigate) in
            
            self.updateAppointmentStatus.updateToFinishedAppointment(appointment: &self.appointment)
                { _ in }
            
            self.getPatientFCMTokenId { _ in
                self.notifHelper.fireAppointmentOverNotif(patientToken: self.patientTokenId)
            }
            
            self.takeToWritePrescription = true
        }
    }

    func viewPatientInfo() {
        docSheetHelper.showPatientInfoSheet(appointment: appointment)
    }

    //get patient token id, if not existing, fetch from api and completing parent call
    func getPatientFCMTokenId (completion: @escaping (_ retrieved:Bool) -> ()) {
        if patientTokenId.isEmpty {
            GetReceptientFCMTokenId.getPatientTokenId(patientId: appointment.requestedBy) { (tokenId) in
                if tokenId != nil {
                    self.patientTokenId = tokenId!
                    completion(true)
                }
            }
        } else {
            completion(true)
        }
    }
}
