//
//  IntermediateAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/5/21.
//

import Foundation
import SwiftUI

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
    @Published var chatVM:DoctorChatViewModel
    
    @Published var childProfile:ServiceProviderCustomerChildProfile? = nil
    
    @Published var cancellationSheetOffset:CGFloat = UIScreen.main.bounds.height
    
    @Published var takeToDetailedAppointment:Bool = false
    @Published var takeToViewAppointment:Bool = false
    
    @Published var takeToChat:Bool = false
    @Published var newChats:Int = 0

    @Published var appointmentStarted:Bool = false
    @Published var appointmentFinished:Bool = false
    
    @Published var showPDFPreview:Bool = false
    
    @Published var showOnSuccessAlert:Bool = false
    @Published var showTwilioRoom:Bool = false
    @Published var collapseExtraDetailEntry:Bool = true
    
    
    var DoctorCancellationReason:[String] = ["This is not my specialty", "I am not available at this time", "Patient did not pick up", "Technical Issues", "Other"]
    
    private var updateAppointmentStatus:ServiceProviderUpdateAppointmentStatusProtocol
    private var docNotifHelper:DocNotifHelpers
    private var doctorAlertHelper:DoctorAlertHelpersProtocol

    init(appointment:ServiceProviderAppointment,
         updateAppointmentStatus:ServiceProviderUpdateAppointmentStatusProtocol = ServiceProviderUpdateAppointmentStatusHelper(),
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
        self.chatVM = DoctorChatViewModel(appointment: appointment)

        doctorTwilioManagerViewModel.twilioDelegate = self
        serviceRequestVM.gotServiceRequestDelegate = self

        docAutoNav.enterIntermediateView(appointmentId: self.appointment.appointmentID)
        refreshAppointment()
    }

    func refreshAppointment () {
        CommonDefaultModifiers.showLoader()
        ServiceProviderAppointmentService().getSingleAppointment(appointmentId: appointment.appointmentID, serviceProviderId: appointment.serviceProviderID) { (appointment) in
            if appointment != nil {
                self.appointment = appointment!
                self.initChecks()
            }
        }
    }

    func refreshPrescription () {
        self.medicineVM.retrievePrescriptions()
    }

    func initChecks () {
        docAutoNav.enterIntermediateView(appointmentId: self.appointment.appointmentID)
        checkDetailedOrView()
        checkIfAppointmentFinished()
        checkIfAppointmentStarted()
        getClinicalInfoCollapseSetting()
        
        getNewChatCount()
        newChatListener()
        CommonDefaultModifiers.hideLoader()
    }
    
    func showCancellationSheet () {
        self.cancellationSheetOffset = 0
    }
}

extension IntermediateAppointmentViewModel {
    func checkForDirectNavigation () {
        if docAutoNav.takeToChat {
            self.doctorAlertHelper.takeToChatAlert { (open) in
                if open {
                    self.takeToChat = true
                    docAutoNav.clearAllValues()
                }
            }
        }

        if docAutoNav.takeToTwilioRoom {
            self.doctorAlertHelper.twilioConnectToRoomAlert { (connect) in
                if connect {
                    self.startConsultation()
                    docAutoNav.clearAllValues()
                }
            }
        }
    }
}

extension IntermediateAppointmentViewModel : LoadedServiceRequestDelegate {
    func gotServiceRequestId(serviceRequestId: String) {
        patientInfoViewModel.retrieveUploadedDocumentList(serviceRequestId: serviceRequestId)
    }
    
    func isForChild(childId: String) {
        let child = patientInfoViewModel.getChildProfile(childId: childId)
        if child != nil {
            self.childProfile = child!
        }
    }
}

//MARK:- VIEW RELATED CALLS
extension IntermediateAppointmentViewModel {
    func toggleCollapseOfClinicalInformation () {
        self.collapseExtraDetailEntry.toggle()
        DefaultPreferencesTracker().setClinicalInfoCollapseExpandSetting(expand: collapseExtraDetailEntry)
    }
    
    func getClinicalInfoCollapseSetting () {
        self.collapseExtraDetailEntry = DefaultPreferencesTracker().getClinicalInfoCollapseExpandSetting()
    }
}

//MARK:- UPDATING INFORMATION CALLS
extension IntermediateAppointmentViewModel {
    func saveForLater(completion: @escaping (_ success:Bool)->()) {
        var allSendsDone:[Bool] = [Bool]()
        
        func onCompletion(success:Bool) {
            allSendsDone.append(success)
            
            if allSendsDone.count == 2 && !allSendsDone.contains(false) {
                completion(true)
            }
        }

        self.appointment.serviceFee = modifyFeeViewModel.convertFeeToDouble()

        serviceRequestVM.sendToPatient { (success, serviceRequestId) in
            onCompletion(success: success)
        }

        self.medicineVM.prescription.serviceRequestID = self.serviceRequestVM.serviceRequest.serviceRequestID
        self.medicineVM.sendToPatient { (success) in
            onCompletion(success: success)
        }
    }

    func sendToPatient () {
        CommonDefaultModifiers.showLoader()

        self.saveForLater { (success) in
            
            if self.appointment.serviceFee == 0 {
                self.appointment.isPaid = true
            }
            
            self.updateAppointmentStatus.updateToFinished(appointment: &self.appointment) { (success) in
                CommonDefaultModifiers.hideLoader()
                self.docNotifHelper.fireAppointmentOverNotif()
                self.checkIfAppointmentFinished()
                self.showOnSuccessAlert = true
            }
        }
    }
    
    func previewPrescription () {
        CommonDefaultModifiers.showLoader()
        self.saveForLater { saved in
            CommonDefaultModifiers.hideLoader()
            self.showPDFPreview = true
        }
    }
}

//MARK:- TWILIO RELATED CALLS
extension IntermediateAppointmentViewModel : TwilioDelegate {
    func callPatientPhone() {
        self.leftRoom()
        self.patientInfoViewModel.callPatient()
    }
    
    func leftRoom() {
        if appointment.status == "Finished" {
            killView = true
        }
        self.showTwilioRoom = false
        docAutoNav.leaveTwilioRoom()
    }

    func startConsultation() {

        guard self.childProfile == nil else {
            doctorAlertHelper.videoCallNotAllowedForChildAlert { _ in
                self.patientInfoViewModel.callPatient()
            }
            return
        }

        EndEditingHelper.endEditing()
        CommonDefaultModifiers.showLoader()
        doctorTwilioManagerViewModel.startRoom() { success in
            if success {
                self.doctorTwilioManagerViewModel.fireStartedNotif() { success in
                    self.appointment.status = ConsultStateK.StartedConsultation.rawValue //need to refresh from db after. using local update for now.
                    self.checkIfAppointmentStarted()
                }

                self.showTwilioRoom = true
                CommonDefaultModifiers.hideLoader()
            } else { }
        }
    }
}

//MARK:- APPOINTMENT RELATED CALLS
extension IntermediateAppointmentViewModel {
    var appointmentServiceFee : String {
        return "₹\(String(appointment.serviceFee.clean))"
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

    func cancelAppointment(completion: @escaping (_ successfullyCancelled:Bool) -> ()) {
        CommonDefaultModifiers.showLoader()
        self.updateAppointmentStatus.toCancelled(appointment: &self.appointment) { (success) in
            if success {
                self.docNotifHelper.fireCancelNotif(appointmentTime: self.appointment.scheduledAppointmentStartTime)
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

//chat count helpers
extension IntermediateAppointmentViewModel {
    func getNewChatCount () {
        self.newChats = LocalNotifStorer().getNumberOfNewChatsForAppointment(appointmentId: self.appointment.appointmentID)
    }

    func newChatListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(SimpleStateK.refreshNewChatCountChange)"), object: nil, queue: .main) { (_) in
            self.getNewChatCount()
        }
    }
}

extension IntermediateAppointmentViewModel : CancellationDelegate {
    func cancel(reasonName: String) {
        
        let cancellation = ServiceProviderCancellation(ReasonName: reasonName,
                                                       CancelledTime: Date().millisecondsSince1970,
                                                       CancelledBy: UserIdHelper().retrieveUserId(),
                                                       CancelledByType: UserTypeHelper.getUserType(),
                                                       Notes: "")
        self.appointment.cancellation = cancellation
        
        self.cancelAppointment { success in
            if success {
                self.killView = true
            }
        }
    }
}

