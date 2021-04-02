//
//  DetailedAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/03/21.
//

import Foundation
import UIKit

class DetailedAppointmentViewModel : ObservableObject {
    @Published var killView:Bool = false
    
    @Published var appointment:ServiceProviderAppointment

    @Published var serviceRequestVM:ServiceRequestViewModel
    @Published var prescriptionVM:MedicineViewModel
    @Published var patientInfoViewModel:PatientInfoViewModel
    @Published var doctorTwilioManagerViewModel:DoctorTwilioViewModel
    @Published var followUpViewModel:FollowUpViewModel
    @Published var modifyFeeViewModel:ModifyFeeViewModel

    @Published var showTwilioRoom:Bool = false
    @Published var consultationHappened:Bool = false
    
    @Published var toggleAddMedicineSheet:Bool = false
    
    @Published var showOnSuccessAlert:Bool = false
    
        
    private var updateAppointmentStatus:UpdateAppointmentStatusProtocol
    private var docNotifHelper:DocNotifHelpers
    private var doctorAlertHelper:DoctorAlertHelpersProtocol

    init(appointment:ServiceProviderAppointment,
         updateAppointmentStatus:UpdateAppointmentStatusProtocol = UpdateAppointmentStatusHelper(),
         doctorAlertHelper:DoctorAlertHelpersProtocol = DoctorAlertHelpers()) {

        self.appointment = appointment
        self.updateAppointmentStatus = updateAppointmentStatus
        self.doctorAlertHelper = doctorAlertHelper
        self.docNotifHelper = DocNotifHelpers(appointment: appointment)

        self.patientInfoViewModel = PatientInfoViewModel(appointment: appointment)
        self.serviceRequestVM = ServiceRequestViewModel(appointment: appointment)
        self.prescriptionVM = MedicineViewModel(appointment: appointment)
        self.followUpViewModel = FollowUpViewModel()
        self.modifyFeeViewModel = ModifyFeeViewModel(fee: appointment.serviceFee.clean)

        self.doctorTwilioManagerViewModel = DoctorTwilioViewModel(appointment: appointment)
        doctorTwilioManagerViewModel.twilioDelegate = self
        CommonDefaultModifiers.showLoader()
        checkIfConsultationHappened()
    }
    
    var appointmentTime:String {
        return "\(Helpers.getTimeFromTimeStamp(timeStamp: appointment.scheduledAppointmentStartTime))"
    }
    
    var customerName:String {
        return "\(appointment.customerName)"
    }
    
    func checkIfConsultationHappened() {
        if appointment.status == ConsultStateK.StartedConsultation.rawValue || appointment.status == ConsultStateK.Finished.rawValue || appointment.status == ConsultStateK.FinishedAppointment.rawValue {
            print("Consultation Happened")
            consultationHappened = true
        }
    }

    func cancelAppointment(completion: @escaping (_ successfullyCancelled:Bool)->()) {
        doctorAlertHelper.cancelAppointmentAlert { (cancel) in
            CommonDefaultModifiers.showLoader()
            self.updateAppointmentStatus.toCancelled(appointment: &self.appointment) { (success) in
                if success {
                    self.docNotifHelper.fireCancelNotif(requestedBy: self.appointment.customerID, appointmentTime: self.appointment.scheduledAppointmentStartTime)
                    DoctorDefaultModifiers.refreshAppointments()
                    CommonDefaultModifiers.hideLoader()
                    completion(success)
                } else {
                    GlobalPopupHelpers.setErrorAlert()
                    CommonDefaultModifiers.hideLoader()
                    completion(success)
                }
            }
        }
    }
    
    func showAddMedicineDisplay () {
        self.toggleAddMedicineSheet = true
    }
    
    func startConsultation() {
        doctorTwilioManagerViewModel.startRoom()
        doctorTwilioManagerViewModel.fireStartedNotif()
        self.showTwilioRoom = true
    }

    func callPatient () {
        guard let number = URL(string: "tel://" + patientInfoViewModel.phoneNumber) else { return }
        UIApplication.shared.open(number)
    }

    func savePrescription(completion: @escaping (_ success:Bool)->()) {
        var allSendsDone:[Bool] = [Bool]()
        
        func onCompletion(success:Bool) {
            allSendsDone.append(success)
            
            if allSendsDone.count == 3 && !allSendsDone.contains(false) {
                completion(true)
            }
        }
        
        self.appointment.serviceFee = modifyFeeViewModel.convertFeeToDouble()

        serviceRequestVM.sendToPatient { (success, serviceRequestId) in
            if success {
                self.prescriptionVM.prescription.serviceRequestID = serviceRequestId!
                self.prescriptionVM.sendToPatient { (success) in
                    onCompletion(success: success)
                }
            }
            
            onCompletion(success: success)
        }

        patientInfoViewModel.sendToPatient { (success) in
            onCompletion(success: success)
        }
    }
    
    func sendToPatient () {
        CommonDefaultModifiers.showLoader()
        self.savePrescription { (success) in
            self.updateAppointmentStatus.updateToFinished(appointment: &self.appointment) { (success) in
                CommonDefaultModifiers.hideLoader()
                DoctorDefaultModifiers.refreshAppointments()
                self.showOnSuccessAlert = true
            }
        }
    }
}

extension DetailedAppointmentViewModel : TwilioDelegate {
    func leftRoom() {
        if appointment.status == "Finished" {
            killView = true
        }
        self.showTwilioRoom.toggle()
    }
}
