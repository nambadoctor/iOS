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

    @Published var imagePickerVM:ImagePickerViewModel = ImagePickerViewModel()
    @Published var customerTwilioViewModel:CustomerTwilioViewModel
    @Published var customerChatViewModel:CustomerChatViewModel

    @Published var allergy:String = ""
    @Published var allergyChanged:Bool = false
    @Published var reasonPickerVM:ReasonPickerViewModel = ReasonPickerViewModel()
    
    @Published var reportsVM:CustomerAllReportsViewModel
    
    @Published var prescriptionPDF:Data? = nil
    
    @Published var imageLoader:ImageLoader? = nil
    @Published var docProfPicImageLoader:ImageLoader? = nil

    @Published var showTwilioRoom:Bool = false
    @Published var takeToChat:Bool = false
    @Published var newChats:Int = 0

    @Published var showPayment:Bool = false

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
        imagePickerVM.imagePickerDelegate = self
        reasonPickerVM.reasonPickedDelegate = self
        customerTwilioViewModel.twilioDelegate = self
        initCalls()
    }

    func initCalls () {
        CommonDefaultModifiers.showLoader()
        self.getAppointment()
        self.getServiceProvider()
        self.getServiceRequest()
        
        self.newChatListener()
        self.getNewChatCount()
    }

    func checkAppointmentStatus () {
        if appointment.status == ConsultStateK.StartedConsultation.rawValue {
            appointmentStarted = true
        } else if appointment.status == ConsultStateK.Finished.rawValue ||
                    appointment.status == ConsultStateK.FinishedAppointment.rawValue {
            appointmentFinished = true
            self.getPrescription()
            self.checkIfPaid()
        } else if appointment.status == ConsultStateK.Confirmed.rawValue {
            appointmnentUpComing = true
        }
        CommonDefaultModifiers.hideLoader()
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
        return "Dr. \(appointment.serviceProviderName)"
    }
    
    var serviceProviderFee : String {
        return "Fee: \(appointment.serviceFee.clean)"
    }

    func getAppointment () {
        self.customerAppointmentService.getSingleAppointment(appointmentId: self.appointment.appointmentID, serviceProviderId: self.appointment.serviceProviderID) { customerAppointment in
            if customerAppointment != nil {
                print(customerAppointment!)
                self.appointment = customerAppointment!
                self.checkAppointmentStatus()
                self.checkForDirectNavigation()
            }
        }
    }

    func getServiceRequest() {
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

            } else {
                //TODO: handle no service request returned
            }
        }
    }

    func getServiceProvider () {
        CustomerServiceProviderService().getServiceProvider(serviceProviderId: appointment.serviceProviderID) { provider in
            if provider != nil {
                self.serviceProvider = provider!
                self.docProfPicImageLoader = ImageLoader(urlString: provider!.profilePictureURL) { _ in }
            }
        }
    }
    
    func getPrescription() {
        CustomerPrescriptionService().getPrescription(appointmentId: appointment.appointmentID, serviceRequestId: appointment.serviceRequestID) { prescription in
            if prescription != nil {
                self.prescription = prescription!
                
                CommonDefaultModifiers.showLoader()
                self.getPrescriptionPDF()
                
                self.getPrescriptionImage()
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
            CommonDefaultModifiers.showLoader()
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
        CommonDefaultModifiers.showLoader()
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
}

extension CustomerDetailedAppointmentViewModel : ImagePickedDelegate {
    func imageSelected() {
        let image:UIImage = imagePickerVM.image!
        
        let encodedImage = image.jpegData(compressionQuality: 0.5)?.base64EncodedString()
        
        let customerReport = CustomerReportUpload(ReportId: "", ServiceRequestId: self.serviceRequest!.serviceRequestID, CustomerId: self.serviceRequest!.customerID, FileName: "", Name: "report", FileType: ".jpg", MediaFile: encodedImage!)
        
        reportsVM.setReport(report: customerReport)
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
        if appointmentStarted {
            CommonDefaultModifiers.showLoader()
            customerTwilioViewModel.startRoom() { success in
                if success {
                    self.showTwilioRoom = true
                    CommonDefaultModifiers.hideLoader()
                } else {
                    
                }
            }
        } else {
            CustomerAlertHelpers().WaitForDoctorToCallFirstAlert { _ in}
        }
    }
}

extension CustomerDetailedAppointmentViewModel : RazorPayDelegate {
    func paymentFailed() {
        CustomerAlertHelpers().PaymentFailedAlert { _ in }
    }
    
    func paymentSucceeded(paymentId: String) {
        CommonDefaultModifiers.showLoader()
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

extension CustomerDetailedAppointmentViewModel : ExpandingTextViewEditedDelegate {
    func changed() {
        self.allergyChanged = true
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
                    cusAutoNav.clearAllValues()
                }
            }
        }

        if cusAutoNav.takeToTwilioRoom {
            CustomerAlertHelpers().twilioConnectToRoomAlert { (connect) in
                if connect {
                    self.startConsultation()
                    cusAutoNav.clearAllValues()
                }
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
