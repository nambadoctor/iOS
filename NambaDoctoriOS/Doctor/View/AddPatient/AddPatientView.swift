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
    
    
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    Section(header: Text("Basic Details")) {
                        TextField("Patient Name", text: $AddPatientVM.preRegisteredPatient.fullName)

                        TextField("Patient Age", text: $AddPatientVM.preRegisteredPatient.age)
                            .keyboardType(.numberPad)

                        SideBySideCheckBox(isChecked: $AddPatientVM.preRegisteredPatient.gender, title1: "male", title2: "female")

                        PhoneNumberEntryView(numberObj: $AddPatientVM.phoneNumObj)
                    }

                    Section(header: Text("Allergies(optional)")) {
                        TextField("Enter patient allergies if any", text: $AddPatientVM.allergies)
                    }

                    MakeFollowUpAppointmentView(followUpAppointmentVM: AddPatientVM.followUpFeeObj)

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
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
            
            LoadingScreen(showLoader: self.$AddPatientVM.loadingScreen)
        }
        .navigationTitle("Add Your Patient")
        .navigationBarItems(trailing: closeButton)
        .alert(isPresented: self.$AddPatientVM.fillAllFieldsAlert, content: {
            Alert(title: Text("Please Fill All Fields!"), dismissButton: Alert.Button.default(Text("Ok")))
        })
    }

    var closeButton : some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
        })
    }
}
