//
//  DetailedBookDocViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

class DetailedBookDocViewModel : ObservableObject {
    var serviceProvider:CustomerServiceProviderProfile
    
    var slots:[CustomerGeneratedSlot]? = nil
    
    var notAbleToBookCallBack:()->()
    
    @Published var customerProfile:CustomerProfile

    @Published var dateDisplay:[Int64] = [Int64]()
    @Published var timeDisplay:[Int64] = [Int64]()
    
    @Published var selectedDate:Int64 = 0
    @Published var selectedTime:Int64 = 0

    @Published var docProfPicImageLoader:ImageLoader? = nil
    
    @Published var reasonVM:ReasonPickerViewModel = ReasonPickerViewModel()
    
    @Published var bookingAppointmentFor:String = "myself"
    
    @Published var addChildVM:AddChildProfileViewModel = AddChildProfileViewModel()
    
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
         notAbleToBookCallBack:@escaping ()->()) {
        self.customerProfile = customerProfile
        self.serviceProvider = serviceProvider
        self.customerServiceProviderService = customerServiceProviderService
        self.notAbleToBookCallBack = notAbleToBookCallBack
        self.retrieveAvailabilities()
        
        if !serviceProvider.profilePictureURL.isEmpty {
            self.docProfPicImageLoader = ImageLoader(urlString: serviceProvider.profilePictureURL) { _ in }
        } else {
            self.docProfPicImageLoader = ImageLoader(urlString: "https://wgsi.utoronto.ca/wp-content/uploads/2020/12/blank-profile-picture-png.png") {_ in}
        }
    }
    
    func refreshCustomerProfile () {
        CustomerProfileService().getCustomerProfile(customerId: self.customerProfile.customerID) { customerProfile in
            if customerProfile != nil {
                self.customerProfile = customerProfile!
                self.checkForLatestChild()
            }
        }
    }
    
    func checkForLatestChild () {
        let child = addChildVM.findMostRecentChild(children: customerProfile.children)
        if child != nil {
            bookForChild(child: child!)
        }
    }

    func retrieveAvailabilities () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Getting Doctor's Availability")
        customerServiceProviderService.getServiceProviderAvailabilities(serviceProviderId: serviceProvider.serviceProviderID) { (slots) in
            if slots != nil || slots?.count != 0 {
                self.slots = slots!
                self.selectedDate = self.slots![0].startDateTime
                self.selectedTime = self.slots![0].startDateTime
                self.getTimesForSelectedDates(selectedDate: self.selectedDate)
                self.parseSlots()
                CommonDefaultModifiers.hideLoader()
            } else {
                //TODO: handle empty slots
            }
        }
    }
    
    func parseSlots () {
        for slot in slots! {
            if !Helpers.compareDate(dates: dateDisplay, toCompareDate: slot.startDateTime) {
                if !self.dateDisplay.contains(slot.startDateTime) {
                    dateDisplay.append(slot.startDateTime)
                }
            }
        }
    }
    
    func getCorrespondingSlot (timestamp:Int64) -> CustomerGeneratedSlot? {
        for slot in slots! {
            if slot.startDateTime == timestamp {
                return slot
            }
        }
        
        return nil
    }
    
    func getTimesForSelectedDates (selectedDate:Int64) {
        self.selectedDate = selectedDate
        self.selectedTime = 0
        timeDisplay.removeAll()
        
        let date = Date(milliseconds: selectedDate)
        
        for slot in slots! {
            let order = Calendar.current.compare(date, to: Date(milliseconds: slot.startDateTime), toGranularity: .day)
            
            if order == .orderedSame {
                timeDisplay.append(slot.startDateTime)
            }
        }
    }
    
    func selectTime (time:Int64) {
        self.selectedTime = time
    }

    func book (completion: @escaping (_ success:Bool)->()) {
        if selectedDate == 0 || selectedTime == 0 {
            CustomerAlertHelpers().pleaseChooseTimeandDateAlert { _ in }
        } else {
            CommonDefaultModifiers.showLoader(incomingLoadingText: "Booking Appointment")
            let slot = getCorrespondingSlot(timestamp: selectedTime)

            let customerAppointment:CustomerAppointment = makeAppointment(slot: slot)

            CustomerAppointmentService().setAppointment(appointment: customerAppointment) { (response) in
                if response != nil {
                    cusAutoNav.enterDetailedView(appointmentId: response!)
                    self.fireBookedNotif(appointmentId: response!)
                    CustomerServiceRequestService().setServiceRequest(serviceRequest: self.makeServiceRequest(appointmentId: response!)) { (response) in
                        if response != nil {
                            CommonDefaultModifiers.hideLoader()
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                } else {
                    self.notAbleToBookCallBack()
                    completion(false)
                }
            }
        }
    }

    func fireBookedNotif (appointmentId:String) {
        var slot = getCorrespondingSlot(timestamp: selectedTime)
        CustomerNotificationHelper.bookedAppointment(customerName: "", dateDisplay: slot!.startDateTime, appointmentId: appointmentId, serviceProviderId: self.serviceProvider.serviceProviderID)
    }

    func makeAppointment(slot:CustomerGeneratedSlot?) -> CustomerAppointment {
        let cancellation = CustomerCancellation(ReasonName: "", CancelledTime: Date().millisecondsSince1970, CancelledBy: "", CancelledByType: "", Notes: "")
        
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
                                                      serviceFee: self.serviceProvider.serviceFee,
                                                      followUpDays: 0,
                                                      isPaid: false,
                                                      scheduledAppointmentStartTime: slot?.startDateTime ?? 0,
                                                      scheduledAppointmentEndTime: slot?.endDateTime ?? 0,
                                                      actualAppointmentStartTime: 0,
                                                      actualAppointmentEndTime: 0,
                                                      createdDateTime: Date().millisecondsSince1970,
                                                      lastModifiedDate: Date().millisecondsSince1970,
                                                      noOfReports: 0,
                                                      cancellation: cancellation,
                                                      childId: "")
        
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
                                                    childId: "")
        
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
