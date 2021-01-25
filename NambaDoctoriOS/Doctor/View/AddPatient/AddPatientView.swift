//
//  AddPatientView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import SwiftUI

struct AddPatientView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var AddPatientVM:AddPatientViewModel = AddPatientViewModel()
    @ObservedObject var FollowUpVM:FollowUpAppointmentViewModel = FollowUpAppointmentViewModel()
    
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("Basic Details")) {
                    TextField("Patient Name", text: $AddPatientVM.preRegisteredPatient.patientName)
                    
                    SideBySideCheckBox(isChecked: $AddPatientVM.preRegisteredPatient.patientGender, title1: "male", title2: "female")
                    
                    PhoneNumberEntryView(numberObj: $AddPatientVM.preRegisteredPatient.phNumberObj)
                }
                
                Section(header: Text("Allergies(optional)")) {
                    TextField("Enter patient allergies if any", text: $AddPatientVM.preRegisteredPatient.patientAllergies)
                }
                
                MakeFollowUpAppointmentView(followUpAppointmentVM: FollowUpVM)

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Spacer()
                        Text("Cancel").foregroundColor(Color.white)
                        Spacer()
                    }.padding(12).background(Color.red).cornerRadius(4)
                }

                Button(action: {
                    AddPatientVM.addPatient { (added) in
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Add Patient").foregroundColor(Color.white)
                        Spacer()
                    }.padding(12).background(Color.green).cornerRadius(4)
                }
            }
        }
        .navigationTitle("Add Your Patient")
    }
}
