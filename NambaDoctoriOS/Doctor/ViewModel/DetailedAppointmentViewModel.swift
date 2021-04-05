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
    @Published var intermediateVM:IntermediateAppointmentViewModel

    @Published var doctorTwilioManagerViewModel:DoctorTwilioViewModel
    @Published var followUpViewModel:FollowUpViewModel
    @Published var modifyFeeViewModel:ModifyFeeViewModel

    @Published var showTwilioRoom:Bool = false
    @Published var consultationHappened:Bool = false

    @Published var toggleAddMedicineSheet:Bool = false

    @Published var showOnSuccessAlert:Bool = false

    @Published var collapseExtraDetailEntry:Bool = false

    private var updateAppointmentStatus:UpdateAppointmentStatusProtocol
    private var docNotifHelper:DocNotifHelpers
    private var doctorAlertHelper:DoctorAlertHelpersProtocol

    init(intermediateVM:IntermediateAppointmentViewModel,
         updateAppointmentStatus:UpdateAppointmentStatusProtocol = UpdateAppointmentStatusHelper(),
         doctorAlertHelper:DoctorAlertHelpersProtocol = DoctorAlertHelpers()) {

        self.appointment = intermediateVM.appointment
        self.intermediateVM = intermediateVM

        self.updateAppointmentStatus = updateAppointmentStatus
        self.doctorAlertHelper = doctorAlertHelper
        self.docNotifHelper = DocNotifHelpers(appointment: intermediateVM.appointment)

        self.followUpViewModel = FollowUpViewModel()
        self.modifyFeeViewModel = ModifyFeeViewModel(fee: intermediateVM.appointment.serviceFee.clean)

        self.doctorTwilioManagerViewModel = DoctorTwilioViewModel(appointment: intermediateVM.appointment)
        doctorTwilioManagerViewModel.twilioDelegate = self
        checkIfConsultationHappened()
        
        if intermediateVM.serviceRequestVM.serviceRequest == nil {
            CommonDefaultModifiers.showLoader()
        }
    }
    
    var appointmentServiceFee : String {
        return "Fee: ₹\(String(appointment.serviceFee.clean))"
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

    func checkIfAppointmentFinished () -> Bool {
        if appointment.status == ConsultStateK.Finished.rawValue {
            return true
        }
        return false
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
        guard let number = URL(string: "tel://" + intermediateVM.patientInfoViewModel.phoneNumber) else { return }
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

        intermediateVM.serviceRequestVM.sendToPatient { (success, serviceRequestId) in
            if success {
                self.intermediateVM.prescriptionVM.prescription.serviceRequestID = serviceRequestId!
                self.intermediateVM.prescriptionVM.sendToPatient { (success) in
                    onCompletion(success: success)
                }
            }

            onCompletion(success: success)
        }

        intermediateVM.patientInfoViewModel.sendToPatient { (success) in
            onCompletion(success: success)
        }
    }

    func sendToPatient () {
        CommonDefaultModifiers.showLoader()

        self.savePrescription { (success) in
            self.updateAppointmentStatus.updateToFinished(appointment: &self.appointment) { (success) in
                CommonDefaultModifiers.hideLoader()
                self.docNotifHelper.fireAppointmentOverNotif(requestedBy: self.appointment.customerID)
                DoctorDefaultModifiers.refreshAppointments()
                self.showOnSuccessAlert = true
            }
        }
    }
    
    func takeToViewScreen () {
        self.intermediateVM.takeToView()
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
