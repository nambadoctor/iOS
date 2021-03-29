//
//  DetailedAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/03/21.
//

import Foundation

class DetailedAppointmentViewModel : ObservableObject {
    @Published var appointment:ServiceProviderAppointment

    @Published var serviceRequestVM:ServiceRequestViewModel
    @Published var prescriptionVM:MedicineViewModel
    @Published var patientInfoViewModel:PatientInfoViewModel
    @Published var doctorTwilioManagerViewModel:DoctorTwilioViewModel

    @Published var openTwilioRoom:Bool = false
    @Published var collapseTwilioRoom:Bool = false
    
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
        
        self.doctorTwilioManagerViewModel = DoctorTwilioViewModel(appointment: appointment)
        doctorTwilioManagerViewModel.twilioDelegate = self
        CommonDefaultModifiers.showLoader()
    }
    
    var appointmentTime:String {
        return "\(Helpers.getTimeFromTimeStamp(timeStamp: appointment.scheduledAppointmentStartTime))"
    }
    
    var customerName:String {
        return "\(appointment.customerName)"
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
        self.openTwilioRoom = true
    }
    
    func sendToPatient () {
        CommonDefaultModifiers.showLoader()
        var allSendsDone:[Bool] = [Bool]()
        
        func onCompletion(success:Bool) {
            allSendsDone.append(success)
            
            if allSendsDone.count == 3 && !allSendsDone.contains(false) {
                CommonDefaultModifiers.hideLoader()
                self.showOnSuccessAlert = true
            }
        }

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
}

extension DetailedAppointmentViewModel : TwilioDelegate {
    func leftRoom() {
        print("DELEGATE ROOM WORKING")
        self.openTwilioRoom.toggle()
    }
}
