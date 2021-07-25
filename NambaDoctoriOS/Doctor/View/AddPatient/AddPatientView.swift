//
//  AddPatientView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/24/21.
//

import SwiftUI

struct AddPatientView: View {
    @ObservedObject var addPatientVM:AddPatientViewModel
    @Binding var showView:Bool
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 20) {
                
                Text("Add Patient")
                    .font(.title)
                    .bold()
                
                Group {
                    Text("FIRST NAME")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    
                    ExpandingTextEntryView(text: self.$addPatientVM.firstName)
                    
                    Text("LAST NAME")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    
                    ExpandingTextEntryView(text: self.$addPatientVM.lastName)
                }
                
                Group {
                    Text("Gender")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    
                    ThreeItemCheckBox(isChecked: self.$addPatientVM.gender,
                                      title1: "Male",
                                      title2: "Female",
                                      title3: "Other",
                                      delegate: self.addPatientVM)
                }
                
                Group {
                    Text("AGE")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    
                    ExpandingTextEntryView(text: self.$addPatientVM.age, keyboardType: .numberPad)
                }
                
                Group {
                    Text("PHONENUMBER")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    
                    PhoneNumberEntryView(numberObj: self.$addPatientVM.phoneNumber)
                }
                
                Toggle(isOn: self.$addPatientVM.scheduleAppointmentToggle) {
                    Text("Schedule Appointment")
                }
                
                if self.addPatientVM.scheduleAppointmentToggle {
                    AvailabilitySelector(availabilitySelectorVM: self.addPatientVM.availabilityVM)
                        .onAppear() {
                            self.addPatientVM.availabilityVM.retrieveAvailabilities()
                        }
                }
                
                LargeButton(title: "Confirm") {
                    self.addPatientVM.confirm()
                }
            }
            .padding()
            
            if self.addPatientVM.killView {
                Text("").onAppear(){self.showView = false}
            }
        }
    }
}
