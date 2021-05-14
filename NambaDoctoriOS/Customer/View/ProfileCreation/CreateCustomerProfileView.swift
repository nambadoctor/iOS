//
//  CreateCustomerProfileView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/13/21.
//

import SwiftUI

class CustomerCreateProfileViewModel: ObservableObject {
    @Published var firstName:String = ""
    @Published var lastName:String = ""
    @Published var gender:String = ""
    @Published var age:String = ""
    
    var phoneNumber:PhoneNumber
    
    init(phoneNumber:PhoneNumber) {
        self.phoneNumber = phoneNumber
    }
    
    func register () {
        
        let phoneNumbers:[PhoneNumber] = [phoneNumber]
        
        let appInfoObj = CustomerAppInfo(authID: AuthenticateService().getUserId(),
                                         authType: "Firebase",
                                         deviceToken: DeviceTokenId,
                                         appInfoID: "",
                                         deviceTokenType: "apn")
        
        let customerProfile = CustomerProfile(customerID: "",
                                              firstName: self.firstName,
                                              lastName: self.lastName,
                                              gender: self.gender,
                                              age: self.age,
                                              phoneNumbers: phoneNumbers,
                                              addresses: [CustomerAddress](),
                                              appInfo: appInfoObj,
                                              languages: ["English"],
                                              emailAddress: "",
                                              activeAppointmentIds: [String](),
                                              completedAppointmentIds: [String](),
                                              profilePicURL: "",
                                              primaryServiceProviderID: "",
                                              Allergies: [CustomerAllergy](),
                                              MedicalHistories: [CustomerMedicalHistory](),
                                              lastModifiedDate: Date().millisecondsSince1970,
                                              createdDate: Date().millisecondsSince1970)
        
        CustomerProfileService().setCustomerProfile(customerProfile: customerProfile) { customerId in
            if customerId != nil {
                LoginDefaultModifiers.signInPatient(userId: customerId!)
            }
        }
    }
}

extension CustomerCreateProfileViewModel : SideBySideCheckBoxDelegate {
    func itemChecked(value: String) {
        self.gender = value
    }
}

//Firstname, lastname, gender (male female other), age

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
