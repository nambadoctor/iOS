//
//  AvailabilitySelectorViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/25/21.
//

import Foundation

class AvailabilitySelectorViewModel : ObservableObject {
    
    var slots:[CustomerGeneratedSlot]? = nil
    
    @Published var dateDisplay:[Int64] = [Int64]()
    @Published var timeDisplay:[Int64] = [Int64]()
    
    @Published var selectedDate:Int64 = 0
    @Published var selectedTime:Int64 = 0
    @Published var selectedSlot:CustomerGeneratedSlot? = nil
    @Published var isPrePaySlot:Bool = false

    var serviceProviderID:String
    
    init(serviceProviderID:String) {
        self.serviceProviderID = serviceProviderID
    }

    func retrieveAvailabilities () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Getting Doctor's Availability")
        CustomerServiceProviderService().getServiceProviderAvailabilities(serviceProviderId: serviceProviderID) { (slots) in
            if slots != nil && !slots!.isEmpty {
                self.slots = slots!
                self.selectedDate = self.slots![0].startDateTime
                self.selectedTime = self.slots![0].startDateTime
                self.getTimesForSelectedDates(selectedDate: self.selectedDate)
                self.parseSlots()
                CommonDefaultModifiers.hideLoader()
            } else {
                CommonDefaultModifiers.hideLoader()
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
    
    func checkIfInPersonSlot () -> Bool {
        if selectedSlot!.addressId.isEmpty {
            return false
        } else {
            return true
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
        self.isPrePaySlot = false
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
        
        if getCorrespondingSlot(timestamp: time)!.paymentType == PaymentTypeEnum.PrePay.rawValue {
            self.isPrePaySlot = true
        } else {
            self.isPrePaySlot = false
        }
    }
    
    func setSlot () {
        self.selectedSlot = getCorrespondingSlot(timestamp: selectedTime)
    }
}
