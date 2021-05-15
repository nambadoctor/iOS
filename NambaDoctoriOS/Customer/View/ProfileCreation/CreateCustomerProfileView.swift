//
//  CreateCustomerProfileView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/13/21.
//

import SwiftUI

struct CreateCustomerProfileView: View {
    
    @ObservedObject var createProfileVM:CustomerCreateProfileViewModel
    
    init() {
        let phoneNumber = LocalStorageHelper().getPhoneNumber()
        self.createProfileVM = CustomerCreateProfileViewModel(phoneNumber: phoneNumber)
    }

    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 20) {
                
                Text("CREATE YOUR PROFILE")
                    .font(.title)
                    .bold()
                
                Group {
                    Text("FIRST NAME")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    
                    ExpandingTextView(text: self.$createProfileVM.firstName)
                    
                    Text("LAST NAME")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    
                    ExpandingTextView(text: self.$createProfileVM.lastName)
                }
                
                Group {
                    Text("Gender")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    
                    ThreeItemCheckBox(isChecked: self.$createProfileVM.gender,
                                      title1: "Male",
                                      title2: "Female",
                                      title3: "Other",
                                      delegate: self.createProfileVM)
                }
                
                Group {
                    Text("AGE")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    
                    ExpandingTextView(text: self.$createProfileVM.age, keyboardType: .numberPad)
                }
                
                LargeButton(title: "Create Profile") {
                    self.createProfileVM.register()
                }
            }
            .padding()
        }
    }
}
