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

    @Published var selectedSlotOption:Bool = false
    
    @Published var showOnlineOrOfflineSlots:String = ""
    
    @Published var addresses:[CustomerAddress] = [CustomerAddress]()
    @Published var selectedAddress:CustomerAddress? = nil
    @Published var showSelectAddressView:Bool = false
    
    var slotSelected:(()->())?

    var serviceProviderID:String
    var organisationID:String
    var organisation:CustomerOrganization? = nil
    
    init(serviceProviderID:String,
         slotSelected:(()->())?,
         organisationId:String) {
        self.serviceProviderID = serviceProviderID
        self.slotSelected = slotSelected
        self.organisationID = organisationId
    }

    func retrieveAvailabilities () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Getting Doctor's Availability")
        if self.organisationID.isEmpty {
            CustomerServiceProviderService().getServiceProviderAvailabilities(serviceProviderId: serviceProviderID) { (slots) in
                self.slotInitCalls(slots: slots)
            }
        } else {
            CustomerServiceProviderService().getServiceProviderAvailableSlotsForOrganisation(serviceProviderId: self.serviceProviderID, organizationId: self.organisationID) { slots in
                self.slotInitCalls(slots: slots)
            }
            retrieveOrganisation()
        }
    }
    
    func retrieveOrganisation () {
        CustomerOrganizationService().getcustomerOrganization(organizationId: self.organisationID) { organisation in
            if organisation != nil {
                self.organisation = organisation!
            }
        }
    }
    
    func slotInitCalls (slots:[CustomerGeneratedSlot]?) {
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
    
    func getOnlyOnlineSlots () {
        clearNoSlotBools()
        self.filteredSlots.removeAll()
        for slot in self.slots! {
            if slot.addressId.isEmpty {
                self.filteredSlots.append(slot)
            }
        }

        guard !self.filteredSlots.isEmpty else {
            noOnlineSlots = true
            CustomerAlertHelpers().noAvailabilityAlert(onlineOrOffLine: "Online")
            return
        }
        
        self.showOnlineOrOfflineSlots = "Show Online Availability"
        setFilterSlots()
    }
    
    func getOnlyInPersonSlots () {
        clearNoSlotBools()
        self.filteredSlots.removeAll()
        for slot in self.slots! {
            if !slot.addressId.isEmpty {
                if self.selectedAddress != nil && self.selectedAddress!.addressID == slot.addressId {
                    self.filteredSlots.append(slot)
                }
            }
        }

        guard !self.filteredSlots.isEmpty else {
            noInPersonSlots = true
            CustomerAlertHelpers().noAvailabilityAlert(onlineOrOffLine: "In-Person")
            return
        }

        self.showOnlineOrOfflineSlots = "Show In-Person Availability"
        setFilterSlots()
    }
    
    func clearNoSlotBools () {
        self.noOnlineSlots = false
        self.noInPersonSlots = false
    }

    func setFilterSlots () {
        self.selectedSlotOption = true
        self.dateDisplay.removeAll()
        self.timeDisplay.removeAll()
        self.selectedDate = self.filteredSlots[0].startDateTime
        self.selectedTime = self.filteredSlots[0].startDateTime
        self.parseSlots(slots: self.filteredSlots)
        self.getTimesForSelectedDates(selectedDate: self.selectedDate, slots: self.filteredSlots)
        
    }
    
    func parseSlots (slots:[CustomerGeneratedSlot]) {
        func makeDateDisplaySLots (slot:CustomerGeneratedSlot) {
            if !Helpers.compareDate(dates: dateDisplay, toCompareDate: slot.startDateTime) {
                if !self.dateDisplay.contains(slot.startDateTime) {
                    dateDisplay.append(slot.startDateTime)
                }
            }
        }
        
        for slot in slots {
            if selectedAddress != nil {
                if slot.addressId == selectedAddress!.addressID {
                    makeDateDisplaySLots(slot: slot)
                }
                
            } else {
                makeDateDisplaySLots(slot: slot)
            }
        }
    }
    
    func seeIfHasSlotOptions () {
        var hasOnlineSlots:Bool = false
        var hasInPersonSlots:Bool = false
        
        for slot in slots! {
            if slot.addressId.isEmpty {
                hasOnlineSlots = true
            } else {
                hasInPersonSlots = true
            }
        }
        
        self.noOnlineSlots = !hasOnlineSlots
        self.noInPersonSlots = !hasInPersonSlots
//        if !self.hasOnlineSlots && !self.hasInPersonSlots {
//            self.selectedSlotOption = true
//        } else if self.hasOnlineSlots || self.hasInPersonSlots {
//            if !(self.hasOnlineSlots && self.hasInPersonSlots) {
//                self.selectedSlotOption = true
//            }
//        }
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

extension AvailabilitySelectorViewModel:SideBySideCheckBoxDelegate {
    func itemChecked(value: String) {
        if value.isEmpty || value == "Show Online Availability" {
            self.getOnlyOnlineSlots()
            self.showOnlineOrOfflineSlots = "Show Online Availability"
        } else if value == "Show In-Person Availability" {
            self.getOnlyInPersonSlots()
            self.showOnlineOrOfflineSlots = "Show In-Person Availability"
        }
    }
}

//address getter logic
extension AvailabilitySelectorViewModel {
    func getAllAddresses (_ completion: @escaping (_ success:Bool, _ error:Bool)->()) {
        var allAddressIds:[String] = [String]()
        
        if !organisationID.isEmpty {
            for slot in slots! {
                if !allAddressIds.contains(slot.addressId) {
                    allAddressIds.append(slot.addressId)
                }
            }
        } else {
            completion(true, false)
        }
        
        if organisation != nil {
            for address in self.organisation!.addresses {
                if allAddressIds.contains(address.addressID) {
                    self.addresses.append(address)
                }
            }
        } else {
            completion(false, true)
        }
        
        if addresses.count == 1 {
            self.selectedAddress = self.addresses[0]
            completion(true, false)
        } else {
            self.selectedSlotOption = true
            self.showSelectAddressView = true
            completion(false, false)
        }
    }
    
    func selectAddress (address:CustomerAddress) {
        self.showSelectAddressView = false
        self.selectedAddress = address
        self.getOnlyInPersonSlots()
    }
}
