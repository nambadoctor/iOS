//
//  AddChildProfileView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/22/21.
//

import SwiftUI

struct AddChildProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var addChilVM:AddChildProfileViewModel = AddChildProfileViewModel()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text("NAME")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            ExpandingTextView(text: $addChilVM.child.Name)

            Text("GENDER")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            ThreeItemCheckBox(isChecked: $addChilVM.child.Gender, title1: "Male", title2: "Female", title3: "Other", delegate: self.addChilVM)

            Text("AGE")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            ExpandingTextView(text: $addChilVM.child.Age, keyboardType: .numberPad)

            Text("PREFERRED PHONE NUMBER")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            
            HStack {
                Text("+91")
                ExpandingTextView(text: $addChilVM.child.PreferredPhoneNumber, keyboardType: .numberPad)
            }
            
            LargeButton(title: "Add Child") {
                self.addChilVM.makeProfile()
            }

            Group {
                Spacer()
                
                if self.addChilVM.dismissView {
                    Text("").onAppear() {self.presentationMode.wrappedValue.dismiss()}
                }
            }
        }
        .padding()
    }
}
