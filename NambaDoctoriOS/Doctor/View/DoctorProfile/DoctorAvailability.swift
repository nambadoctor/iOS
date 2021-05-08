//
//  DoctorAvailability.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/7/21.
//

import SwiftUI

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
                                .onTapGesture () {
                                    self.availabilityVM.startEdit(availability: availability)
                                    self.availabilityVM.shouldPresentActionScheet = true
                                }
                                .modifier(AvailabilityEditorModifier(availabilityVM: self.availabilityVM))
                            }
                        }
                    }
                    
                    Divider()
                }
            }
        }
    }
}

struct AvailabilityEditorModifier: ViewModifier {
    @ObservedObject var availabilityVM:DoctorAvailabilityViewModel
    func body(content: Content) -> some View {
        content
            .actionSheet(isPresented: $availabilityVM.shouldPresentActionScheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose One"), message: Text("Would you like to edit or remove this availability?"), buttons: [ActionSheet.Button.default(Text("Edit"), action: {
                            //availabilityVM.startEdit(availability: availability)
                        }), ActionSheet.Button.default(Text("Remove"), action: {
                            availabilityVM.removeAndSave(availabilityId: availabilityVM.availabilityToEdit)
                        }), ActionSheet.Button.default(Text("Cancel"), action: {
                            availabilityVM.cancelEdit()
                        })])
                    }
    }
}
