//
//  AddChildProfileView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/22/21.
//

import SwiftUI

struct AddChildProfileView: View {
    
    @ObservedObject var addChilVM:AddChildProfileViewModel
    var caretakerProfile:CustomerProfile
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text("Add Profile")
                .font(.title)
                .bold()
                .padding(.bottom)
            
            Text("NAME")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            
            TextField("", text: $addChilVM.child.Name)
                .padding(10)
                .background(Color.gray.opacity(0.09))
                .cornerRadius(5)
            
            Group {
                Text("GENDER")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                ThreeItemCheckBox(isChecked: $addChilVM.child.Gender, title1: "Male", title2: "Female", title3: "Other", delegate: self.addChilVM)
            }
            
            Text("AGE")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            TextField("", text: $addChilVM.child.Age)
                .padding(10)
                .background(Color.gray.opacity(0.09))
                .cornerRadius(5)
                .keyboardType(.numberPad)

            Text("PREFERRED PHONE NUMBER")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)

            Group {
                Toggle("Same as my number", isOn: $addChilVM.child.IsPrimaryContact)
                    .onChange(of: addChilVM.child.IsPrimaryContact) { value in
                        addChilVM.togglePrimaryNumber(careTakerNumbers: caretakerProfile.phoneNumbers)
                    }
                
                if addChilVM.child.IsPrimaryContact {
                    PhoneNumberEntryView(numberObj: $addChilVM.phoneNumber, isDisabled: true)
                } else {
                    PhoneNumberEntryView(numberObj: $addChilVM.phoneNumber)
                }
            }

            LargeButton(title: "Add Child") {
                self.addChilVM.makeProfile()
            }
            
            Spacer()
        }
        .padding()
    }
}


struct AddProfileViewMod: ViewModifier {
    @ObservedObject var addChildVM:AddChildProfileViewModel
    var customerProfile:CustomerProfile
    let callback: ()->()?
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$addChildVM.showSheet) {
                AddChildProfileView(addChilVM: self.addChildVM, caretakerProfile: self.customerProfile)
                    .onDisappear() {
                        callback()
                    }
            }
    }
}
