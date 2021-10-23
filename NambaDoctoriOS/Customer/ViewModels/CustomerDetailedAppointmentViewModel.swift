//
//  CustomerDetailedAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/29/21.
//

import Foundation
import SwiftUI
import PDFKit

class CustomerDetailedAppointmentViewModel: ObservableObject {
    @Published var appointment:CustomerAppointment
    @Published var serviceRequest:CustomerServiceRequest? = nil
    @Published var prescription:CustomerPrescription? = nil
    @Published var serviceProvider:CustomerServiceProviderProfile? = nil

    @Published var appointmentStarted:Bool = false
    @Published var appointmentFinished:Bool = false
    @Published var appointmnentUpComing:Bool = false
    @Published var isPaid:Bool = false

    @Published var customerTwilioViewModel:CustomerTwilioViewModel
    @Published var customerChatViewModel:CustomerChatViewModel

    @Published var allergy:String = ""
    @Published var allergyChanged:Bool = false
    @Published var reasonPickerVM:ReasonPickerViewModel = ReasonPickerViewModel()
    @Published var reasonChanged:Bool = false

    @Published var reportsVM:CustomerAllReportsViewModel
    @Published var ratingVM:CustomerRatingViewModel
        
    @Published var prescriptionPDF:Data? = nil

    @Published var imageLoader:ImageLoader? = nil
    @Published var imageLoaders:[ImageLoader]? = nil
    @Published var docProfPicImageLoader:ImageLoader? = nil

    @Published var showTwilioRoom:Bool = false
    @Published var takeToChat:Bool = false
    @Published var newChats:Int = 0

    @Published var showPayment:Bool = false
    
    @Published var killViewTrigger:Bool = false
    
    @Published var refreshViewTrigger:Bool = true
    
    @Published var needToPayFirst:Bool = false
    @Published var appointmentIsBeingConfirmed = false
    
    @Published var cancellationSheetOffset:CGFloat = UIScreen.main.bounds.height
    @Published var cancellationDisclaimerText:String = ""
    
    var CustomerCancellationReasons:[String] = ["I booked by mistake", "Doctor said he is not available", "Doctor did not call me", "Technical Issues", "Other"]

    var customerServiceRequestService:CustomerServiceRequestServiceProtocol
    var customerAppointmentService:CustomerAppointmentServiceProtocol
    
    var customerNotifHelpers:CustomerNotificationHelper

    init(appointment:CustomerAppointment,
         customerServiceRequestService:CustomerServiceRequestServiceProtocol = CustomerServiceRequestService(),
         customerAppointmentService:CustomerAppointmentServiceProtocol = CustomerAppointmentService()) {

        self.appointment = appointment
        self.customerServiceRequestService = customerServiceRequestService
        self.customerAppointmentService = customerAppointmentService
        self.customerTwilioViewModel = CustomerTwilioViewModel(appointment: appointment)
        self.customerChatViewModel = CustomerChatViewModel(appointment: appointment)
        self.customerNotifHelpers = CustomerNotificationHelper(appointment: appointment)
        self.reportsVM = CustomerAllReportsViewModel(appointment: appointment)
        self.ratingVM = CustomerRatingViewModel(appointment: appointment)
        reasonPickerVM.reasonPickedDelegate = self
        customerTwilioViewModel.twilioDelegate = self
        initCalls()
    }

    func initCalls () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Getting Appointment Details")
        
        var allCallsDone:[Bool] = [Bool]()
        
        func onCompletion(success:Bool) {
            allCallsDone.append(success)
            
            if allCallsDone.count == 2 && !allCallsDone.contains(false) {
                viewSettingChecks()
                CommonDefaultModifiers.hideLoader()
            }
        }

        self.getAppointment { getAppointmentCompletion in
            onCompletion(success: getAppointmentCompletion)
        }

        self.getServiceRequest() { getServiceRequestCompletion in
            onCompletion(success: getServiceRequestCompletion)
        }
        
        self.getServiceProvider()

        self.newChatListener()
        self.getNewChatCount()
        
        self.prePayCheck()
    }
    
    func prePayCheck () {
        self.needToPayFirst = false
        if self.appointment.paymentType == PaymentTypeEnum.PrePay.rawValue && !self.appointment.isPaid {
            self.needToPayFirst = true
        } else if self.appointment.appointmentVerification != nil && appointment.appointmentVerification?.VerificationStatus == "PendingVerification"{
            self.appointmentIsBeingConfirmed = true
        }
        else {
            self.reportsVM.checkIfFirstTimeOpeningAppointment()
        }
    }

    func checkAppointmentStatus () {
        self.checkIfPaid()
        
        if appointment.status == ConsultStateK.StartedConsultation.rawValue {
            appointmentStarted = true
        } else if appointment.status == ConsultStateK.Finished.rawValue ||
                    appointment.status == ConsultStateK.FinishedAppointment.rawValue {
            appointmentFinished = true
            self.getPrescription()
        } else if appointment.status == ConsultStateK.Confirmed.rawValue {
            appointmnentUpComing = true
        }
        
        //self.checkIfAlreadyReviewed()
        CommonDefaultModifiers.hideLoader()
    }
    
    func refreshView () {
        refreshViewTrigger = false
        refreshViewTrigger = true
    }

    func checkIfPaid () {
        self.isPaid = appointment.isPaid
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
    
    var serviceProviderName : String {
        return appointment.serviceProviderName
    }
    
    var serviceProviderFee : String {
        return "Fee: \(appointment.serviceFee.clean)"
    }

    func viewSettingChecks () {
        self.resetAllValues()
        self.checkAppointmentStatus()
        self.checkForDirectNavigation()
        self.prePayCheck()
    }

    func getAppointment (_ completion: @escaping (_ retrieved:Bool)->()) {
        self.customerAppointmentService.getSingleAppointment(appointmentId: self.appointment.appointmentID, serviceProviderId: self.appointment.serviceProviderID) { customerAppointment in
            if customerAppointment != nil {
                self.appointment = customerAppointment!
                completion(true)
            }
        }
    }

    func getServiceRequest(_ completion: @escaping (_ retrieved:Bool)->()) {
        self.customerServiceRequestService.getServiceRequest(appointmentId: self.appointment.appointmentID,
                                                             serviceRequestId: self.appointment.serviceRequestID,
                                                             customerId: self.appointment.customerID) { serviceRequest in
            if serviceRequest != nil {
                self.serviceRequest = serviceRequest!
                self.allergy = serviceRequest!.allergy.AllergyName
                
                if !serviceRequest!.reason.isEmpty {
                    self.reasonPickerVM.reason = serviceRequest!.reason
                    self.reasonPickerVM.reasonSelected()
                }
                
                completion(true)
            } else {
                //TODO: handle no service request returned
            }
        }
    }

    func getServiceProvider () {
        CustomerServiceProviderService().getServiceProvider(serviceProviderId: appointment.serviceProviderID) { provider in
            if provider != nil {
                self.serviceProvider = provider!
                if !provider!.profilePictureURL.isEmpty {
                    self.docProfPicImageLoader = ImageLoader(urlString: provider!.profilePictureURL) { _ in }
                } else {
                    self.docProfPicImageLoader = ImageLoader(urlString: "https://wgsi.utoronto.ca/wp-content/uploads/2020/12/blank-profile-picture-png.png") { _ in }
                }
            }
        }
    }
    
    func getPrescription() {
        CustomerPrescriptionService().getPrescription(appointmentId: appointment.appointmentID, serviceRequestId: appointment.serviceRequestID) { prescription in
            if prescription != nil {
                self.prescription = prescription!
                
                CommonDefaultModifiers.showLoader(incomingLoadingText: "Geting Prescription")
                self.getPrescriptionPDF()
                
                if self.prescription?.fileInfo.FileType.toPlain == "png" {
                    self.getPrescriptionImage()
                }
                
                if !prescription!.uploadedPrescriptionDocuments.isEmpty {
                    self.imageLoaders = [ImageLoader]()
                    for uploadedDoc in prescription!.uploadedPrescriptionDocuments {
                        CustomerPrescriptionService().downloadPrescription(prescriptionID: uploadedDoc.FileInfoId) { (imageDataURL) in
                            if imageDataURL != nil {
                                self.imageLoaders?.append(ImageLoader(urlString: imageDataURL!) { _ in})
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getPrescriptionPDF () {
        CustomerPrescriptionService().getPrescriptionPDF(serviceProviderId: appointment.serviceProviderID, appointmentId: appointment.appointmentID, serviceRequestId: appointment.serviceRequestID) { data in
            if data != nil {
                CommonDefaultModifiers.hideLoader()
                self.prescriptionPDF = data!
            }
        }
    }

    func getPrescriptionImage () {
        
        CustomerPrescriptionService().downloadPrescription(prescriptionID: prescription!.prescriptionID) { url in
            if url != nil {
                self.imageLoader = ImageLoader(urlString: url!) { success in
                    CommonDefaultModifiers.hideLoader()
                    if !success {
                        self.imageLoader = nil
                    } else {
                        //self.showRemoveButton = true
                    }
                }
            }
        }
    }

    func cancelAppointment(completion: @escaping (_ successfullyCancelled:Bool)->()) {
        DoctorAlertHelpers().cancelAppointmentAlert { (cancel) in
            CommonDefaultModifiers.showLoader(incomingLoadingText: "Cancelling Appointment")
            CustomerUpdateAppointmentStatusHelper().toCancelled(appointment: &self.appointment) { (success) in
                if success {
                    //TODO: Fire cancelled notification
                    CommonDefaultModifiers.hideLoader()
                    completion(success)
                    self.customerNotifHelpers.cancelledAppointment()
                } else {
                    GlobalPopupHelpers.setErrorAlert()
                    CommonDefaultModifiers.hideLoader()
                    completion(success)
                }
            }
        }
    }
    
    func cancelAppointmentBeforePayment (completion: @escaping (_ successfullyCancelled:Bool)->()) {
        DoctorAlertHelpers().cancelAppointmentBeforePaymentAlert { (cancel) in
            CommonDefaultModifiers.showLoader(incomingLoadingText: "Cancelling")
            CustomerUpdateAppointmentStatusHelper().toCancelled(appointment: &self.appointment) { (success) in
                if success {
                    //TODO: Fire cancelled notification
                    CommonDefaultModifiers.hideLoader()
                    completion(success)
                    self.customerNotifHelpers.cancelledAppointment()
                } else {
                    GlobalPopupHelpers.setErrorAlert()
                    CommonDefaultModifiers.hideLoader()
                    completion(success)
                }
            }
        }
    }
    
    func showCancellationSheet () {
        
        let hourDiff = Helpers.getHourDifference(timestamp: self.appointment.scheduledAppointmentStartTime)
        
        if self.appointment.isPaid {
            if hourDiff >= 3 {
                self.cancellationDisclaimerText = "YOU WILL GET FULL REFUND WITHIN 3 - 5 BUSINESS DAYS"
            } else if hourDiff < 3 {
                self.cancellationDisclaimerText = "YOU WILL GET \((self.appointment.serviceFee * 0.3).clean)rs REFUNDED IN 3 - 5 BUSINESS DAYS"
            }
        }
        
        self.cancellationSheetOffset = 0
    }
    
    func setServiceRequest (_ completion: @escaping (_ success:Bool)->()) {
        self.serviceRequest!.allergy.AllergyName = self.allergy
        self.serviceRequest!.allergy.AppointmentId = self.appointment.appointmentID
        self.serviceRequest!.allergy.ServiceRequestId = self.serviceRequest!.serviceRequestID
        
        self.serviceRequest!.reason = self.reasonPickerVM.reason
        
        customerServiceRequestService.setServiceRequest(serviceRequest: self.serviceRequest!) { response in
            if response != nil {
                completion(true)
            }
        }
    }

    func makePayment() {
        self.showPayment = true
    }
    
    func razorPayEndPoint() -> RazorPayDisplay {
        //TODO: ADD CUSTOMER NUMBER
        return RazorPayDisplay(customerAppointment: self.appointment,
                               delegate: self)
    }
    
    func commitAllergy () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Saving Allergy")
        self.setServiceRequest() { success in
            if success {
                self.allergyChanged = false
                CommonDefaultModifiers.hideLoader()
                CustomerAlertHelpers().AllergySetSuccessfully { _ in }
                EndEditingHelper.endEditing()
            } else {
                CustomerAlertHelpers().AllergySetFailed() { _ in }
            }
        }
    }
    
    func commitReason () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Saving Reason")
        self.setServiceRequest() { success in
            if success {
                self.reasonChanged = false
                CommonDefaultModifiers.hideLoader()
                CustomerAlertHelpers().ReasonSetSuccessfully { _ in }
                EndEditingHelper.endEditing()
            } else {
                CustomerAlertHelpers().ReasonSetFailed() { _ in }
            }
        }
    }
}

extension CustomerDetailedAppointmentViewModel : ReasonPickedDelegate {
    func reasonSelected(reason: String) {
        self.setServiceRequest() { _ in }
    }
}

//MARK:- TWILIO RELATED CALLS
extension CustomerDetailedAppointmentViewModel : TwilioDelegate {
    func callPatientPhone() {}
    
    func leftRoom() {
        self.showTwilioRoom.toggle()
        cusAutoNav.leaveTwilioRoom()
    }

    func startConsultation() {
        LoggerService().log(eventName: "Patient trying to start consultation")
        if appointmentStarted {
            CommonDefaultModifiers.showLoader(incomingLoadingText: "Starting Consultation")
            customerTwilioViewModel.startRoom() { success in
                if success {
                    CustomerFirebaseUpdateAppointmentStatus(appointmentId: self.appointment.appointmentID).writePatientJoinedState()
                    LoggerService().log(eventName: "Patient entering")
                    self.showTwilioRoom = true
                    CommonDefaultModifiers.hideLoader()
                } else {
                    LoggerService().log(eventName: "PATIENT SIDE - error in starting consultation room")
                }
            }
        } else {
            LoggerService().log(eventName: "Trying to call doctor before consultation started")
            CustomerSnackbarHelpers().waitForDoctorToCall(doctorName: self.appointment.serviceProviderName)
        }
    }
}

extension CustomerDetailedAppointmentViewModel : RazorPayDelegate {
    func paymentFailed() {
        CustomerAlertHelpers().PaymentFailedAlert { _ in }
    }
    
    func paymentSucceeded(paymentId: String) {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Verifying Payment")
        let paymentInfo = CustomerPaymentInfo(serviceProviderID: self.appointment.serviceProviderID,
                                              appointmentID: self.appointment.appointmentID,
                                              paidAmmount: self.appointment.serviceFee,
                                              paidDate: Date().millisecondsSince1970,
                                              paymentGateway: "Razorpay",
                                              paymentTransactionID: paymentId,
                                              paymentTransactionNotes: "none",
                                              customerID: self.appointment.customerID,
                                              serviceProviderName: self.appointment.serviceProviderName,
                                              customerName: self.appointment.customerName)
        
        customerAppointmentService.setPayment(paymentInfo: paymentInfo) { success in
            CustomerDefaultModifiers.triggerAppointmentStatusChanges()
            CustomerAlertHelpers().PaymentSuccessAlert { _ in
                CommonDefaultModifiers.hideLoader()
            }
        }
    }
}

extension CustomerDetailedAppointmentViewModel {
    func resetAllValues () {
        self.appointmentStarted = false
        self.appointmentFinished = false
        self.appointmnentUpComing = false
        self.isPaid = false
        self.showTwilioRoom = false
        self.takeToChat = false
        self.showPayment = false
    }
}

extension CustomerDetailedAppointmentViewModel {
    func checkForDirectNavigation () {
        
        cusAutoNav.enterDetailedView(appointmentId: self.appointment.appointmentID)
        
        if cusAutoNav.takeToChat {
            CustomerAlertHelpers().takeToChatAlert { (open) in
                if open {
                    self.takeToChat = true
                }
                cusAutoNav.leaveChatRoom()
            }
        }

        if cusAutoNav.takeToTwilioRoom {
            CustomerAlertHelpers().twilioConnectToRoomAlert { (connect) in
                if connect {
                    self.takeToChat = false
                    self.startConsultation()
                }
                cusAutoNav.leaveTwilioRoom()
            }
        }
    }
}

extension CustomerDetailedAppointmentViewModel {
    func getNewChatCount () {
        self.newChats = LocalNotifStorer().getNumberOfNewChatsForAppointment(appointmentId: self.appointment.appointmentID)
    }   

    func newChatListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(SimpleStateK.refreshNewChatCountChange)"), object: nil, queue: .main) { (_) in
            self.getNewChatCount()
        }
    }
}

extension CustomerDetailedAppointmentViewModel : CancellationDelegate {
    func cancel(reasonName: String) {
        
        let cancellation = CustomerCancellation(ReasonName: reasonName,
                                                       CancelledTime: Date().millisecondsSince1970,
                                                       CancelledBy: UserIdHelper().retrieveUserId(),
                                                       CancelledByType: UserTypeHelper.getUserType(),
                                                       Notes: "")
        self.appointment.cancellation = cancellation
        
        self.cancelAppointment { success in
            if success {
                self.killViewTrigger = true
            }
        }
    }
}

extension CustomerDetailedAppointmentViewModel {
    func allergyChangedTrigger () {
        allergyChanged = true
    }
    
    func reasonChangedTrigger () {
        reasonChanged = true
    }
}

extension CustomerDetailedAppointmentViewModel {
    func checkIfAlreadyReviewed () {
//        RatingAndReviewService().getRatingAndReview(appointmentId: self.appointment.appointmentID) { rating in
//            if rating == nil && self.appointmentFinished {
//                DispatchQueue.main.async {
//                    self.ratingVM.presentRatingSheet = true
//                }
//            }
//        }
    }
}
