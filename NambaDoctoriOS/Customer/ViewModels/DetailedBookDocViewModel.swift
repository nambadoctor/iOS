//
//  DetailedBookDocViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation
import SwiftUI

class DetailedBookDocViewModel : ObservableObject {
    var serviceProvider:CustomerServiceProviderProfile
    var organization:CustomerOrganization?
    
    var notAbleToBookCallBack:()->()
    
    @Published var customerProfile:CustomerProfile
    
    @Published var customerVitals:CustomerVitals = CustomerVitals(BloodPressure: "", BloodSugar: "", Height: "", Weight: "", MenstrualHistory: "", ObstetricHistory: "", IsSmoker: false, IsAlcoholConsumer: false)
    
    @Published var availabilityVM:AvailabilitySelectorViewModel
    
    @Published var docProfPicImageLoader:ImageLoader? = nil
    
    @Published var reasonVM:ReasonPickerViewModel = ReasonPickerViewModel()
    
    @Published var bookingAppointmentFor:String = "myself"
    
    @Published var addChildVM:AddChildProfileViewModel = AddChildProfileViewModel()
    
    @Published var killView:Bool = false
    
    @Published var slotIsSelected:Bool = false
    
    @Published var preBookingOptionsOffSet:CGFloat = UIScreen.main.bounds.height
    var preBookingOptions:[String] = ["I dont know this doctor", "This doctor referred me", "Other"]
    var selectedPrebookingOption:String = ""
    
    var bookingForProfile:CustomerChildProfile? = nil
    
    var customerServiceProviderService:CustomerServiceProviderServiceProtocol
    
    var serviceProviderName : String {
        return "\(serviceProvider.firstName) \(serviceProvider.lastName)"
    }
    
    var serviceProviderFee : String { 
        return "Fee: \(serviceProvider.serviceFee.clean)"
    }
    
    init(serviceProvider:CustomerServiceProviderProfile,
         customerServiceProviderService:CustomerServiceProviderServiceProtocol = CustomerServiceProviderService(),
         customerProfile:CustomerProfile,
         organization:CustomerOrganization?,
         notAbleToBookCallBack:@escaping ()->()) {
        self.customerProfile = customerProfile
        self.serviceProvider = serviceProvider
        self.organization = organization
        self.customerServiceProviderService = customerServiceProviderService
        self.notAbleToBookCallBack = notAbleToBookCallBack
        if !serviceProvider.profilePictureURL.isEmpty {
            self.docProfPicImageLoader = ImageLoader(urlString: serviceProvider.profilePictureURL) { _ in }
        } else {
            self.docProfPicImageLoader = ImageLoader(urlString: "https://wgsi.utoronto.ca/wp-content/uploads/2020/12/blank-profile-picture-png.png") { _ in }
        }
        
        self.availabilityVM = AvailabilitySelectorViewModel(serviceProviderID: serviceProvider.serviceProviderID, slotSelected: nil, organisationId: self.organization?.organisationId ?? "", overrideAvailability: false, doctorBookingForSelf: false)
        self.availabilityVM.slotSelected = self.selectSlot
        self.availabilityVM.retrieveAvailabilities()
    }
    
    func refreshCustomerProfile () {
        CustomerProfileService().getCustomerProfile(customerId: self.customerProfile.customerID) { customerProfile in
            if customerProfile != nil {
                self.customerProfile = customerProfile!
                self.checkForLatestChild()
            }
        }
        
        CustomerProfileService().getTrustScore(serviceProviderId: self.serviceProvider.serviceProviderID) { trustScore in
            if trustScore != nil {
                CustomerTrustScore = trustScore!
            }
        }
    }
    
    func checkForLatestChild () {
        let child = addChildVM.findMostRecentChild(children: customerProfile.children ?? [CustomerChildProfile]())
        if child != nil {
            bookForChild(child: child!)
        }
    }
    
    func checkTrustScores () {
        guard availabilityVM.selectedDate != 0, availabilityVM.selectedTime != 0 else {
            CustomerAlertHelpers().pleaseChooseTimeandDateAlert { _ in }
            return
        }
        
        self.availabilityVM.setSlot()

        guard self.availabilityVM.selectedSlot?.paymentType != PaymentTypeEnum.PrePay.rawValue else {
            bookHelper()
            return
        }
        
        if checkIfSkipFraudPrevention() {
            bookHelper()
        } else {
            print("CUSTOMER TRUST SCOORORREE \(CustomerTrustScore)")
            if CustomerTrustScore == 0 {
                self.showPreBookingOptionsSheet()
            } else if CustomerTrustScore < 0 {
                self.availabilityVM.selectedSlot?.paymentType = PaymentTypeEnum.PrePay.rawValue
                bookHelper()
            } else if 0 < CustomerTrustScore && CustomerTrustScore < 100 {
                self.availabilityVM.selectedSlot?.paymentType = PaymentTypeEnum.PostPay.rawValue
                bookHelper()
            } else if CustomerTrustScore == 100 {
                self.availabilityVM.selectedSlot?.paymentType = PaymentTypeEnum.PostPay.rawValue
                bookHelper()
            }
            else {
                CustomerAlertHelpers().IssueDuringBooking(doctorName: self.serviceProviderName)
            }
        }
    }
    
    func checkIfSkipFraudPrevention () -> Bool {
        return self.serviceProvider.configurableSettings != nil && self.serviceProvider.configurableSettings!.SkipFraudPrevention
    }
    
    func bookHelper () {
        self.book() { success, paymentType, needsVerification in
            if success {
                if needsVerification {
                    CustomerAlertHelpers().AppointmentNeedsVerificationAlert(doctorName: self.serviceProviderName,timeStamp: self.availabilityVM.selectedTime) { (done) in
                        CommonDefaultModifiers.showLoader(incomingLoadingText: "Please Wait")
                        CustomerDefaultModifiers.navigateToDetailedView()
                        self.killView = true
                    }
                } else if paymentType == PaymentTypeEnum.PostPay.rawValue {
                    CustomerAlertHelpers().AppointmentBookedAlert(timeStamp: self.availabilityVM.selectedTime) { (done) in
                        CommonDefaultModifiers.showLoader(incomingLoadingText: "Loading Appointment")
                        CustomerDefaultModifiers.navigateToDetailedView()
                        self.killView = true
                    }
                } else {
                    CommonDefaultModifiers.showLoader(incomingLoadingText: "Please Wait")
                    CustomerDefaultModifiers.navigateToDetailedView()
                    self.killView = true
                }
            } else {
                self.killView = true
            }
        }
    }
    
    func book (completion: @escaping (_ success:Bool, _ paymentType:String, _ needsVerification:Bool)->()) {
        
        let customerAppointment:CustomerAppointment = makeAppointment()
        
        if customerAppointment.paymentType == PaymentTypeEnum.PostPay.rawValue && customerAppointment.appointmentVerification == nil {
            CommonDefaultModifiers.showLoader(incomingLoadingText: "Booking Appointment")
        } else {
            CommonDefaultModifiers.showLoader(incomingLoadingText: "Please Wait")
        }
        
        let needsVerif = customerAppointment.appointmentVerification != nil ? true : false
        
        CustomerAppointmentService().setAppointment(appointment: customerAppointment) { (response) in
            if response != nil {
                cusAutoNav.enterDetailedView(appointmentId: response!)
                self.fireBookedNotif(appointment: customerAppointment)
                CustomerServiceRequestService().setServiceRequest(serviceRequest: self.makeServiceRequest(appointmentId: response!)) { (response) in
                    if response != nil {
                        CommonDefaultModifiers.hideLoader()
                        completion(true, customerAppointment.paymentType, needsVerif)
                    } else {
                        completion(false, customerAppointment.paymentType, needsVerif)
                    }
                }
            } else {
                self.notAbleToBookCallBack()
                completion(false, customerAppointment.paymentType, needsVerif)
            }
        }
    }
    
    func fireBookedNotif (appointment:CustomerAppointment) {
        guard appointment.paymentType != PaymentTypeEnum.PrePay.rawValue, appointment.appointmentVerification == nil else { return }
        CustomerNotificationHelper.bookedAppointment(customerName: "", dateDisplay: availabilityVM.selectedSlot!.startDateTime, appointmentId: appointment.childId, serviceProviderId: self.serviceProvider.serviceProviderID)
    }
    
    func makeAppointment() -> CustomerAppointment {
        let addresObj = CustomerAddress(streetAddress: "", state: "", country: "", pinCode: "", type: "", addressID: self.availabilityVM.selectedSlot!.addressId, googleMapsAddress: "")
        
        var customerAppointment = CustomerAppointment(appointmentID: "",
                                                      serviceRequestID: "",
                                                      parentAppointmentID: "",
                                                      customerID: UserIdHelper().retrieveUserId(),
                                                      serviceProviderID: self.serviceProvider.serviceProviderID,
                                                      requestedBy: UserIdHelper().retrieveUserId(),
                                                      serviceProviderName: "",
                                                      customerName: "",
                                                      isBlockedByServiceProvider: false,
                                                      status: "Confirmed",
                                                      serviceFee: self.availabilityVM.selectedSlot?.serviceFees ?? 0,
                                                      followUpDays: 0,
                                                      isPaid: false,
                                                      scheduledAppointmentStartTime: self.availabilityVM.selectedSlot?.startDateTime ?? 0,
                                                      scheduledAppointmentEndTime: self.availabilityVM.selectedSlot?.endDateTime ?? 0,
                                                      actualAppointmentStartTime: 0,
                                                      actualAppointmentEndTime: 0,
                                                      createdDateTime: Date().millisecondsSince1970,
                                                      lastModifiedDate: Date().millisecondsSince1970,
                                                      noOfReports: 0,
                                                      cancellation: nil,
                                                      childId: "",
                                                      paymentType: self.availabilityVM.selectedSlot?.paymentType ?? "",
                                                      organisationId: organization?.organisationId ?? "",
                                                      organisationName: organization?.name ?? "",
                                                      IsInPersonAppointment: self.availabilityVM.checkIfInPersonSlot(),
                                                      Address: addresObj,
                                                      AppointmentTransfer: nil)
        
        if !checkIfSkipFraudPrevention() {
            if !selectedPrebookingOption.isEmpty {
                if !preBookingOptions.contains(selectedPrebookingOption) || preBookingOptions[0] == selectedPrebookingOption {
                    customerAppointment.paymentType = PaymentTypeEnum.PrePay.rawValue
                } else {
                    customerAppointment.appointmentVerification = CustomerAppointmentVerification(AppointmentVerificationId: "", VerificationStatus: "PendingVerification", VerifiedBy: "", VerifiedTime: nil, CustomerResponseForReason: self.selectedPrebookingOption)
                }
            } else if 0 < CustomerTrustScore && CustomerTrustScore < 100 {
                if 0 < CustomerTrustScore && CustomerTrustScore < 50 {
                    customerAppointment.appointmentVerification = CustomerAppointmentVerification(AppointmentVerificationId: "", VerificationStatus: "PendingVerification", VerifiedBy: "", VerifiedTime: nil, CustomerResponseForReason: "Override By Admin - Existing User But Doubtful score")
                }
            }
        }
        
        if self.bookingForProfile != nil {
            customerAppointment.childId = bookingForProfile!.ChildProfileId
        }
        
        return customerAppointment
    }
    
    func makeServiceRequest (appointmentId:String) -> CustomerServiceRequest {
        
        let emptyDiagnosis = CustomerDiagnosis(name: "", type: "")
        let emptyAllergy = CustomerAllergy(AllergyId: "", AllergyName: "", AppointmentId: "", ServiceRequestId: "")
        let emptyMedicalHistory = CustomerMedicalHistory(MedicalHistoryId: "", MedicalHistoryName: "", PastMedicalHistory: "", MedicationHistory: "", AppointmentId: "", ServiceRequestId: "")
        
        var serviceRequest = CustomerServiceRequest(serviceRequestID: "",
                                                    reason: self.reasonVM.reason,
                                                    serviceProviderID: serviceProvider.serviceProviderID,
                                                    appointmentID: appointmentId,
                                                    examination: "",
                                                    diagnosis: emptyDiagnosis,
                                                    investigations: [String](),
                                                    advice: "",
                                                    createdDateTime: Date().millisecondsSince1970,
                                                    lastModifiedDate: Date().millisecondsSince1970,
                                                    customerID: UserIdHelper().retrieveUserId(),
                                                    allergy: emptyAllergy,
                                                    medicalHistory: emptyMedicalHistory,
                                                    childId: "",
                                                    customerVitals: customerVitals,
                                                    organisationId: organization?.organisationId ?? "",
                                                    additionalEntryFields: makeEmptyCustomerAdditionalEntryFields())

        if self.bookingForProfile != nil {
            serviceRequest.childId = bookingForProfile!.ChildProfileId
        }
        
        return serviceRequest
    }
}

//profile booking
extension DetailedBookDocViewModel {
    func bookForMe () {
        self.bookingAppointmentFor = "Me"
        self.bookingForProfile = nil
    }
    
    func bookForChild (child:CustomerChildProfile) {
        self.bookingForProfile = child
        self.bookingAppointmentFor = child.Name
    }
}

extension DetailedBookDocViewModel {
    func preBookingOptionsCallback (reason:String) {
        self.selectedPrebookingOption = reason
        bookHelper()
    }
    
    func showPreBookingOptionsSheet () {
        self.preBookingOptionsOffSet = 0
    }
}

extension DetailedBookDocViewModel {
    func selectSlot () {
        self.slotIsSelected = true
    }
}
