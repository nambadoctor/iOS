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
        
        let serviceRequest = CustomerServiceRequest(serviceRequestID: "", reason: self.reasonForAppointment, serviceProviderID: self.serviceProvider.serviceProviderID, appointmentID: "", examination: "", diagnosis: <#T##CustomerDiagnosis#>, investigations: <#T##[String]#>, advice: <#T##String#>, createdDateTime: <#T##Int64#>, lastModifiedDate: <#T##Int64#>, customerID: <#T##String#>, allergy: <#T##CustomerAllergy#>, medicalHistory: <#T##CustomerMedicalHistory#>)
        
        CustomerServiceRequestService().setServiceRequest(serviceRequest: <#T##CustomerServiceRequest#>, completion: <#T##((String?) -> ())##((String?) -> ())##(String?) -> ()#>)
    }
}
