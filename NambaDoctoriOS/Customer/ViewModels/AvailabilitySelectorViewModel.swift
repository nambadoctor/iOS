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
    
    @Published var hasOnlineSlots:Bool = false
    @Published var hasInPersonSlots:Bool = false
    @Published var selectedSlotOption:Bool = false
    
    var slotSelected:(()->())?

    var serviceProviderID:String
    
    init(serviceProviderID:String,
         slotSelected:(()->())?) {
        self.serviceProviderID = serviceProviderID
        self.slotSelected = slotSelected
    }

    func retrieveAvailabilities () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Getting Doctor's Availability")
        CustomerServiceProviderService().getServiceProviderAvailabilities(serviceProviderId: serviceProviderID) { (slots) in
            if slots != nil && !slots!.isEmpty {
                self.slots = slots!
                self.filteredSlots = slots!
                self.seeIfHasSlotOptions()
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
        self.selectedSlotOption = true
        clearNoSlotBools()
        self.filteredSlots.removeAll()
        for slot in self.slots! {
            if slot.addressId.isEmpty {
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
        self.selectedSlotOption = true
        clearNoSlotBools()
        self.filteredSlots.removeAll()
        for slot in self.slots! {
            if !slot.addressId.isEmpty {
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
        self.setSlotSelectedCallback()
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
    
    func seeIfHasSlotOptions () {
        for slot in slots! {
            if slot.addressId.isEmpty {
                self.hasOnlineSlots = true
            } else {
                self.hasInPersonSlots = true
            }
        }

        print("HAS ONLINE: \(hasOnlineSlots) HAS IN PERSON: \(hasInPersonSlots)")
        if !self.hasOnlineSlots && !self.hasInPersonSlots {
            self.selectedSlotOption = true
        } else if self.hasOnlineSlots || self.hasInPersonSlots {
            if !(self.hasOnlineSlots && self.hasInPersonSlots) {
                self.selectedSlotOption = true
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
        
        self.setSlotSelectedCallback()
    }
    
    func setSlotSelectedCallback () {
        if self.selectedSlotOption {
            self.slotSelected?()
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
