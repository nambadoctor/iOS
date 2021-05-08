//
//  DoctorAvailabilityView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/21/21.
//

import SwiftUI

class DoctorAvailabilityViewModel : ObservableObject {
    var serviceProviderId:String = ""
    
    @Published var availabilities:[ServiceProviderAvailability] = [ServiceProviderAvailability]()
    @Published var showView:Bool = false
    
    @Published var availabilityToEdit:String = "nil"
    @Published var editStartTime:Date = Date()
    @Published var editEndTime:Date = Date()
    
    @Published var shouldPresentActionScheet:Bool = false
    
    @Published var makeNewSlotToggle:Int = 1000
    
    func getAvailabilities (serviceProviderId:String) {
        self.serviceProviderId = serviceProviderId
        ServiceProviderProfileService().getServiceProviderAvailabilities(serviceProviderId: serviceProviderId) { (availabilities) in
            if availabilities != nil {
                self.availabilities = availabilities!
                self.showView = true
            }
        }
    }
    
    func getAvailabilitiesForDayOfWeek (dayOfWeek:Int32) -> [ServiceProviderAvailability] {
        var tempArr:[ServiceProviderAvailability] = [ServiceProviderAvailability]()
        for avail in self.availabilities {
            if avail.dayOfWeek == dayOfWeek {
                tempArr.append(avail)
            }
        }
        
        return tempArr
    }
    
    func removeAvailability (availabilityId:String) {
        var index = 0
        for avail in availabilities {
            if avail.availabilityConfigID == availabilityId {
                do {
                    availabilities.remove(at: index)
                } catch {
                    print(error.localizedDescription)
                    DoctorAlertHelpers().errorRemovingAvailabilitySlotAlert()
                }
            }
            index+=1
        }
        refreshView()
    }
    
    func removeAndSave (availabilityId:String) {
        removeAvailability(availabilityId: availabilityId)
        saveAvailabilities()
    }
    
    func startEdit (availability:ServiceProviderAvailability) {
        self.availabilityToEdit = availability.availabilityConfigID
        mapStartandEndTime(availability: availability)
    }
    
    func cancelEdit () {
        self.availabilityToEdit = "nil"
        editEndTime = Date()
        editStartTime = Date()
    }

    func endEdit (availability:ServiceProviderAvailability) {
        removeAvailability(availabilityId: availability.availabilityConfigID)
        
        var tempAvail = availability
        tempAvail.startTime = editStartTime.millisecondsSince1970
        tempAvail.endTime = editEndTime.millisecondsSince1970
        availabilities.append(tempAvail)
        
        availabilityToEdit = "nil"
        refreshView()
        saveAvailabilities()
    }
    
    func makeNewSlot (day:Int) {
        self.makeNewSlotToggle = day
    }
    
    func confirmNewSlot (day:Int) {
        let newSlot = ServiceProviderAvailability(dayOfWeek: Int32(day), startTime: editStartTime.millisecondsSince1970, endTime: editEndTime.millisecondsSince1970, availabilityConfigID: "")
        
        availabilities.append(newSlot)
        self.makeNewSlotToggle = 1000
        saveAvailabilities()
        refreshView()
    }

    func cancelMakingNewSlot () {
        self.makeNewSlotToggle = 1000
    }

    func mapStartandEndTime (availability:ServiceProviderAvailability) {
        editStartTime = Helpers.getDateFromTimeStamp(timeStamp: availability.startTime)
        editEndTime = Helpers.getDateFromTimeStamp(timeStamp: availability.endTime)
    }
    
    func saveAvailabilities () {
        print(availabilities.count)
        ServiceProviderProfileService().setServiceProviderAvailabilities(serviceProviderId: self.serviceProviderId, availabilities: self.availabilities) { (success) in
            print("AVAILABILITIES SET SUCCESSFULLY")
        }
    }

    func refreshView () {
        self.showView = false
        self.showView = true
    }
}
