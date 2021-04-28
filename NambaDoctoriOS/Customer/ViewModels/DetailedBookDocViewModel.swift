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
    
    @Published var dateDisplay:[Int64] = [Int64]()
    @Published var timeDisplay:[Int64] = [Int64]()
    
    @Published var selectedDate:Int64 = 0
    @Published var selectedTime:Int64 = 0
    
    @Published var reasonForAppointment:String = ""
    
    var customerServiceProviderService:CustomerServiceProviderServiceProtocol
    
    init(serviceProvider:CustomerServiceProviderProfile,
         customerServiceProviderService:CustomerServiceProviderServiceProtocol = CustomerServiceProviderService()) {
        self.serviceProvider = serviceProvider
        self.customerServiceProviderService = customerServiceProviderService
        self.retrieveAvailabilities()
    }
    
    func retrieveAvailabilities () {
        customerServiceProviderService.getServiceProviderAvailabilities(serviceProviderId: serviceProvider.serviceProviderID) { (slots) in
            if slots != nil || slots?.count != 0 {
                self.slots = slots!
                
                self.selectedDate = self.slots![0].startDateTime
                self.selectedTime = self.slots![0].startDateTime
                self.getTimesForSelectedDates(selectedDate: self.selectedDate)
                
                self.parseSlots()
            } else {
                //TODO: handle empty slots
            }
        }
    }
    
    func parseSlots () {
        for slot in slots! {
            if !Helpers.compareDate(dates: dateDisplay, toCompareDate: slot.startDateTime) {
                dateDisplay.append(slot.startDateTime)
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
    
    func book () {
        
        let emptyDiagnosis = CustomerDiagnosis(name: "", type: "")
        let emptyAllergy = CustomerAllergy(AllergyId: "", AllergyName: "", AppointmentId: "", ServiceRequestId: "")
        let emptyMedicalHistory = CustomerMedicalHistory(MedicalHistoryId: "", MedicalHistoryName: "", AppointmentId: "", ServiceRequestId: "")
        
        func makeServiceRequest (appointmentId:String) -> CustomerServiceRequest {
            return CustomerServiceRequest(serviceRequestID: "",
                                          reason: self.reasonForAppointment,
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
                                          medicalHistory: emptyMedicalHistory)
        }
        
        let slot = getCorrespondingSlot(timestamp: selectedTime)
        
        let customerAppointment:CustomerAppointment = CustomerAppointment(appointmentID: "",
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
                                                                          scheduledAppointmentEndTime: slot?.endStartDateTime ?? 0,
                                                                          actualAppointmentStartTime: 0,
                                                                          actualAppointmentEndTime: 0,
                                                                          createdDateTime: Date().millisecondsSince1970,
                                                                          lastModifiedDate: Date().millisecondsSince1970,
                                                                          noOfReports: 0)
        
        CustomerAppointmentService().setAppointment(appointment: customerAppointment) { (response) in
            if response != nil {
                CustomerServiceRequestService().setServiceRequest(serviceRequest: makeServiceRequest(appointmentId: response!)) { (response) in
                    if response != nil {
                        self.bookedSuccessfullyAlert()
                    }
                }
            }
        }
    }
    
    func bookedSuccessfullyAlert () {
        CustomerAlertHelpers().AppointmentBookedAlert { (done) in
            CommonDefaultModifiers.hideLoader()
        }
    }
}
