//
//  AddPatientView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/24/21.
//

import SwiftUI

struct AddPatientView: View {
    @ObservedObject var addPatientVM:AddPatientViewModel
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 20) {
                
                Group {
                    Text("PHONENUMBER")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    
                    HStack {
                        PhoneNumberEntryView(numberObj: self.$addPatientVM.phoneNumber)
                        Button {
                            self.addPatientVM.confirmPhoneNumber()
                        } label: {
                            Text("Add")
                        }

                    }
                }
                
                if self.addPatientVM.phoneNumberConfirmed {
                    Text("Add Patient")
                        .font(.title)
                        .bold()
                    
                    Group {
                        Text("NAME")
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
                    
                    
                    if !self.addPatientVM.patientAlreadyExists {
                        Text("If you would like to book appointment, you can do so after creating patient profile")
                    }
                    
                    LargeButton(title: self.addPatientVM.patientAlreadyExists ? "Confirm and Schedule Appointment" : "Confirm") {
                        self.addPatientVM.confirm { success in
                            if success {
                                DoctorAlertHelpers().patientAddedAlert { dismiss, scheduleAppointment in
                                    if scheduleAppointment {
                                        self.addPatientVM.takeToScheduleAppointment()
                                    } else {
                                        DoctorDefaultModifiers.refreshAppointments()
                                        self.addPatientVM.finished = true
                                    }
                                }
                            } else {
                                
                            }
                        }
                    }
                    .sheet(isPresented: self.$addPatientVM.showSelectDoctorView, content: {
                        SelectServiceProvidersView(organisationServiceProvidersVM: self.addPatientVM.makeOrganisationsServiceProvidersViewModel())
                    })
                }
            }
            .padding()
        }
    }
}
