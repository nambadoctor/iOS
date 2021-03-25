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
    }
    
    var appointmentTime:String {
        return "\(Helpers.getTimeFromTimeStamp(timeStamp: appointment.scheduledAppointmentStartTime))"
    }
    
    var customerName:String {
        return "\(appointment.customerName)"
    }

    func cancelAppointment() {
        doctorAlertHelper.cancelAppointmentAlert { (cancel) in
            self.updateAppointmentStatus.toCancelled(appointment: &self.appointment) { (success) in
                if success {
                    self.docNotifHelper.fireCancelNotif(requestedBy: self.appointment.customerID, appointmentTime: self.appointment.scheduledAppointmentStartTime)
                    DoctorDefaultModifiers.refreshAppointments()
                    //self.checkToShowCancelButton()
                } else {
                    GlobalPopupHelpers.setErrorAlert()
                }
            }
        }
    }
}
