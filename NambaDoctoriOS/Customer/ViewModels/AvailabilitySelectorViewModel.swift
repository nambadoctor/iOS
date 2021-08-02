//
//  AvailabilitySelectorViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/25/21.
//

import Foundation

class AvailabilitySelectorViewModel : ObservableObject {
    
    var slots:[CustomerGeneratedSlot]? = nil
    var filteredSlots:[CustomerGeneratedSlot] = [CustomerGeneratedSlot]()
    
    @Published var dateDisplay:[Int64] = [Int64]()
    @Published var timeDisplay:[Int64] = [Int64]()
    
    @Published var selectedDate:Int64 = 0
    @Published var selectedTime:Int64 = 0
    @Published var selectedSlot:CustomerGeneratedSlot? = nil
    @Published var isPrePaySlot:Bool = false
    
    @Published var noAvailabilities:Bool = false
    
    @Published var noInPersonSlots:Bool = false
    @Published var noOnlineSlots:Bool = false

    var serviceProviderID:String
    
    init(serviceProviderID:String) {
        self.serviceProviderID = serviceProviderID
    }

    func retrieveAvailabilities () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Getting Doctor's Availability")
        CustomerServiceProviderService().getServiceProviderAvailabilities(serviceProviderId: serviceProviderID) { (slots) in
            if slots != nil && !slots!.isEmpty {
                self.slots = slots!
                self.filteredSlots = slots!
                self.selectedDate = self.slots![0].startDateTime
                self.selectedTime = self.slots![0].startDateTime
                self.parseSlots(slots: self.slots!)
                self.getTimesForSelectedDates(selectedDate: self.selectedDate, slots: self.slots!)
                CommonDefaultModifiers.hideLoader()
            } else {
                CommonDefaultModifiers.hideLoader()
                self.noAvailabilities = true
            }
        }
    }
    
    func getOnlyOnlineSlots () {
        clearNoSlotBools()
        self.filteredSlots.removeAll()
        for slot in self.slots! {
            if !slot.isOrganisationSlot {
                self.filteredSlots.append(slot)
            }
        }

        guard !self.filteredSlots.isEmpty else {
            self.noInPersonSlots = false
            noOnlineSlots = true
            return
        }
        
        setFilterSlots()
    }
    
    func getOnlyInPersonSlots () {
        clearNoSlotBools()
        self.filteredSlots.removeAll()
        for slot in self.slots! {
            if slot.isOrganisationSlot {
                self.filteredSlots.append(slot)
            }
        }

        guard !self.filteredSlots.isEmpty else {
            self.noOnlineSlots = false
            noInPersonSlots = true
            return
        }
        
        setFilterSlots()
    }
    
    func clearNoSlotBools () {
        self.noOnlineSlots = false
        self.noInPersonSlots = false
    }
    
    func setFilterSlots () {
        self.dateDisplay.removeAll()
        self.timeDisplay.removeAll()
        self.selectedDate = self.filteredSlots[0].startDateTime
        self.selectedTime = self.filteredSlots[0].startDateTime
        self.parseSlots(slots: self.filteredSlots)
        self.getTimesForSelectedDates(selectedDate: self.selectedDate, slots: self.filteredSlots)
    }
    
    func parseSlots (slots:[CustomerGeneratedSlot]) {
        for slot in slots {
            if !Helpers.compareDate(dates: dateDisplay, toCompareDate: slot.startDateTime) {
                if !self.dateDisplay.contains(slot.startDateTime) {
                    dateDisplay.append(slot.startDateTime)
                }
            }
        }
    }
    
    func checkIfInPersonSlot () -> Bool {
        return selectedSlot!.isOrganisationSlot
    }

    func getCorrespondingSlot (timestamp:Int64) -> CustomerGeneratedSlot? {
        for slot in slots! {
            if slot.startDateTime == timestamp {
                return slot
            }
        }

        return nil
    }
    
    func getTimesForSelectedDates (selectedDate:Int64, slots:[CustomerGeneratedSlot]) {
        self.selectedDate = selectedDate
        timeDisplay.removeAll()
        self.isPrePaySlot = false
        let date = Date(milliseconds: selectedDate)
        
        for slot in slots {
            let order = Calendar.current.compare(date, to: Date(milliseconds: slot.startDateTime), toGranularity: .day)
            
            if order == .orderedSame {
                timeDisplay.append(slot.startDateTime)
            }
        }
        
        self.selectedTime = timeDisplay[0]
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
