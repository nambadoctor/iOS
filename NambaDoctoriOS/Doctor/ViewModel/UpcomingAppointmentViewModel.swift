//
//  AppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation
import SwiftUI

class UpcomingAppointmentViewModel: ObservableObject {
    @Published var appointment:Nambadoctor_V1_AppointmentObject

    @Published var consultationStarted:Bool = false
    @Published var consultationDone:Bool = false

    @Published var takeToTwilioRoom:Bool = false
    @Published var takeToWritePrescription:Bool = false
    @Published var takeToViewPatientInfo:Bool = false

    @Published var showCancelButton:Bool = true

    private var patientTokenId:String = ""
    private var notifHelper:DocNotifHelpers = DocNotifHelpers()
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()

    private var updateAppointmentStatus:UpdateAppointmentStatusProtocol
    private var doctorAlertHelper:DoctorAlertHelpersProtocol
    private var twilioAccessTokenHelper:TwilioAccessTokenProtocol

    init(appointment:Nambadoctor_V1_AppointmentObject,
         updateAppointmentStatus:UpdateAppointmentStatusProtocol = UpdateAppointmentStatusViewModel(),
         doctorAlertHelper:DoctorAlertHelpersProtocol = DoctorAlertHelpers(),
         twilioAccessTokenHelper:TwilioAccessTokenProtocol = RetrieveTwilioAccessToken()) {
        
        self.appointment = appointment

        self.updateAppointmentStatus = updateAppointmentStatus
        self.twilioAccessTokenHelper = twilioAccessTokenHelper
        self.doctorAlertHelper = doctorAlertHelper

        checkIfConsultationStarted()
        checkToShowCancelButton()
    }

    var LocalTime:String {
        return "Time module not done"
    }
    
    var appointmentId:String {
        return self.appointment.appointmentID
    }

    var cardBackgroundColor:Color {
        return appointment.status == ConsultStateK.StartedConsultation.rawValue ? Color(UIColor.green).opacity(0.5) : Color.white
    }
    
    func checkIfConsultationStarted() {
        if appointment.status != ConsultStateK.StartedConsultation.rawValue {
            consultationStarted = false
        } else {
            consultationStarted = true
        }
    }

    func checkToShowCancelButton() {
        if appointment.status != ConsultStateK.Confirmed.rawValue {
            self.showCancelButton = false
        } else {
            self.showCancelButton = true
        }
    }
    
    func cancelAppointment() {
        updateAppointmentStatus.toCancelled(appointmentId: appointmentId) { (success) in
            if success {
                self.getPatientFCMTokenId { _ in
                    //self.notifHelper.fireCancelNotif(patientToken: self.patientTokenId, appointmentTime: self.appointment.slotDateTime)
                }
                DoctorDefaultModifiers.refreshAppointments()
            } else {
                GlobalPopupHelpers.setErrorAlert()
            }
        }
    }

    func startConsultation() {
        CommonDefaultModifiers.showLoader()
        twilioAccessTokenHelper.retrieveToken(appointmentId: appointmentId) { (success, token) in
            if success {
                self.updateAppointmentStatus.updateToStartedConsultation(appointmentId: self.appointmentId) { (success) in
                    if success {
                        CommonDefaultModifiers.hideLoader()
                        self.takeToTwilioRoom = true
                        self.getPatientFCMTokenId { _ in
                            //self.notifHelper.fireStartedConsultationNotif(patientToken: self.patientTokenId, appointmentTime: self.appointment.slotDateTime)
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
            
            self.updateAppointmentStatus.updateToFinishedAppointment(appointmentId: self.appointmentId)
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
            GetReceptientFCMTokenId.getTokenId(patientId: appointment.requestedBy) { (tokenId) in
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
