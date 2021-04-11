//
//  IntermediateAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/5/21.
//

import Foundation

class IntermediateAppointmentViewModel : ObservableObject {
    @Published var killView:Bool = false
    @Published var appointment:ServiceProviderAppointment

    //main view models
    @Published var serviceRequestVM:ServiceRequestViewModel
    @Published var medicineVM:MedicineViewModel
    @Published var patientInfoViewModel:PatientInfoViewModel
    
    //helper view models
    @Published var modifyFeeViewModel:ModifyFeeViewModel
    @Published var doctorTwilioManagerViewModel:DoctorTwilioViewModel

    @Published var takeToDetailedAppointment:Bool = false
    @Published var takeToViewAppointment:Bool = false

    @Published var appointmentStarted:Bool = false
    @Published var appointmentFinished:Bool = false
    
    @Published var showOnSuccessAlert:Bool = false
    @Published var showTwilioRoom:Bool = false
    @Published var collapseExtraDetailEntry:Bool = true
    
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

        //main view model inits
        self.medicineVM = MedicineViewModel(appointment: appointment)
        self.patientInfoViewModel = PatientInfoViewModel(appointment: appointment)
        self.serviceRequestVM = ServiceRequestViewModel(appointment: appointment)
        
        //helper view model inits
        self.modifyFeeViewModel = ModifyFeeViewModel(fee: appointment.serviceFee.clean)
        self.doctorTwilioManagerViewModel = DoctorTwilioViewModel(appointment: appointment)

        doctorTwilioManagerViewModel.twilioDelegate = self
        serviceRequestVM.gotServiceRequestDelegate = self
        
        initChecks()
    }
    
    func refreshPrescription () {
        self.medicineVM.retrievePrescriptions()
    }

    func initChecks () {
        checkDetailedOrView()
        checkIfAppointmentFinished()
        checkIfAppointmentStarted()
    }
}

extension IntermediateAppointmentViewModel : LoadReportsWithServiceRequestDelegate {
    func gotServiceRequestId(serviceRequestId: String) {
        patientInfoViewModel.retrieveUploadedDocumentList(serviceRequestId: serviceRequestId)
    }
}

//MARK:- UPDATING INFORMATION CALLS
extension IntermediateAppointmentViewModel {
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
                self.medicineVM.prescription.serviceRequestID = serviceRequestId!
                self.medicineVM.sendToPatient { (success) in
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
                self.docNotifHelper.fireAppointmentOverNotif(requestedBy: self.appointment.customerID)
                DoctorDefaultModifiers.refreshAppointments()
                self.checkIfAppointmentFinished()
                self.showOnSuccessAlert = true
            }
        }
    }
}

//MARK:- TWILIO RELATED CALLS
extension IntermediateAppointmentViewModel : TwilioDelegate {
    func leftRoom() {
        if appointment.status == "Finished" {
            killView = true
        }
        self.showTwilioRoom.toggle()
    }
    
    func startConsultation() {
        doctorTwilioManagerViewModel.startRoom()
        doctorTwilioManagerViewModel.fireStartedNotif() { success in
            self.appointment.status = ConsultStateK.StartedConsultation.rawValue //need to refresh from db after. using local update for now.
            self.checkIfAppointmentStarted()
        }
        self.showTwilioRoom = true
    }
}

//MARK:- APPOINTMENT RELATED CALLS
extension IntermediateAppointmentViewModel {
    var appointmentServiceFee : String {
        return "Fee: ₹\(String(appointment.serviceFee.clean))"
    }
    
    var appointmentScheduledStartTime:String {
        return "\(Helpers.getTimeFromTimeStamp(timeStamp: appointment.scheduledAppointmentStartTime))"
    }
    
    var appointmentScheduledEndTime:String {
        return "\(Helpers.getTimeFromTimeStamp(timeStamp: appointment.scheduledAppointmentEndTime))"
    }
    
    var appointmentActualStartTime:String {
        return "\(Helpers.getTimeFromTimeStamp(timeStamp: appointment.actualAppointmentStartTime))"
    }
    
    var appointmentActualEndTime:String {
        return "\(Helpers.getTimeFromTimeStamp(timeStamp: appointment.actualAppointmentEndTime))"
    }
    
    var customerName:String {
        return "\(appointment.customerName)"
    }

    var isPaid:Bool {
        return appointment.isPaid
    }

    func checkIfAppointmentStarted () {
        if appointment.status == ConsultStateK.StartedConsultation.rawValue
        {
            self.appointmentStarted = true
        }
    }

    func checkIfAppointmentFinished() {
        if appointment.status == ConsultStateK.Finished.rawValue ||
                    appointment.status == ConsultStateK.FinishedAppointment.rawValue
        {
            self.appointmentFinished = true
        }
    }

    func checkDetailedOrView () {
        if appointment.status == ConsultStateK.Confirmed.rawValue || appointment.status == ConsultStateK.StartedConsultation.rawValue {
            takeToDetailed()
        } else {
            takeToView()
        }
    }
    
    func takeToDetailed () {
        self.takeToDetailedAppointment = true
        self.takeToViewAppointment = false
    }
    
    func takeToView () {
        self.takeToDetailedAppointment = false
        self.takeToViewAppointment = true
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
}
