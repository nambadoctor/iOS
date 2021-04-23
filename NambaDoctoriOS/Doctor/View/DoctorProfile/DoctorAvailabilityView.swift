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
    
    @Published var makeNewSlotToggle:Int = 1000
    
    func getAvailabilities (serviceProviderId:String) {
        self.serviceProviderId = serviceProviderId
        ServiceProviderGetSetServiceCall().getServiceProviderAvailabilities(serviceProviderId: serviceProviderId) { (availabilities) in
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
    
    func removeAvailability (availability:ServiceProviderAvailability) {
        var index = 0
        for avail in availabilities {
            if avail.availabilityConfigID == availability.availabilityConfigID {
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
    
    func removeAndSave (availability:ServiceProviderAvailability) {
        removeAvailability(availability: availability)
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
        removeAvailability(availability: availability)
        
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
        ServiceProviderGetSetServiceCall().setServiceProviderAvailabilities(serviceProviderId: self.serviceProviderId, availabilities: self.availabilities) { (success) in
            print("AVAILABILITIES SET SUCCESSFULLY")
        }
    }

    func refreshView () {
        self.showView = false
        self.showView = true
    }
}

struct DoctorAvailabilityView: View {
    @ObservedObject var availabilityVM:DoctorAvailabilityViewModel = DoctorAvailabilityViewModel()
    var body: some View {
        VStack {
            if availabilityVM.showView {
                ForEach((0...6), id: \.self) { day in
                    VStack (alignment: .leading) {
                        HStack (spacing: 5) {
                            Text(Helpers.getDayForDayOfWeekInt(dayInt: day))
                                .font(.headline)
                            
                            Button(action: {
                                availabilityVM.makeNewSlot(day: day)
                            }, label: {
                                Image("plus.circle.fill")
                                    .foregroundColor(.blue)
                            })
                            Spacer()
                        }
                        
                        if availabilityVM.makeNewSlotToggle == day {
                            HStack {
                                DatePicker("", selection: $availabilityVM.editStartTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                
                                Text("-")
                                
                                DatePicker("", selection: $availabilityVM.editEndTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                
                                Button(action: {
                                    availabilityVM.confirmNewSlot(day: day)
                                }, label: {
                                    Image("checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .padding()
                                })
                                
                                Button(action: {
                                    availabilityVM.cancelMakingNewSlot()
                                }, label: {
                                    Image("xmark.circle.fill")
                                        .foregroundColor(.red)
                                        .padding()
                                })
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                        
                        ForEach(availabilityVM.getAvailabilitiesForDayOfWeek(dayOfWeek: Int32(day)), id: \.availabilityConfigID) { availability in
                            if availabilityVM.availabilityToEdit == availability.availabilityConfigID {
                                HStack {
                                    DatePicker("", selection: $availabilityVM.editStartTime, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                    
                                    Text("-")
                                    
                                    DatePicker("", selection: $availabilityVM.editEndTime, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                    
                                    Button(action: {
                                        availabilityVM.endEdit(availability: availability)
                                    }, label: {
                                        Image("checkmark.circle.fill")
                                            .foregroundColor(.green)
                                            .padding()
                                    })

                                    Button(action: {
                                        availabilityVM.cancelEdit()
                                    }, label: {
                                        Image("xmark.circle.fill")
                                            .foregroundColor(.red)
                                            .padding()
                                    })
                                }
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                            } else {
                                HStack {
                                    Text("\(Helpers.getSimpleTimeForAppointment(timeStamp1: availability.startTime)) - \(Helpers.getSimpleTimeForAppointment(timeStamp1: availability.endTime))")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(10)
                                .onTapGesture {
                                    DoctorAlertHelpers().editOrRemoveAvailabilityAlert(slotTime: "\(Helpers.getSimpleTimeForAppointment(timeStamp1: availability.startTime)) - \(Helpers.getSimpleTimeForAppointment(timeStamp1: availability.endTime))") { (edit, remove) in
                                        if edit {
                                            availabilityVM.startEdit(availability: availability)
                                        } else {
                                            availabilityVM.removeAndSave(availability: availability)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Divider()
                }
            }
        }
    }
}
