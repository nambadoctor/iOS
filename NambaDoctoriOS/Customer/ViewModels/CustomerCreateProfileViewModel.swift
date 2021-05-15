//
//  CustomerCreateProfileViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/14/21.
//

import Foundation

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
        
        phoneNumber.type = "Primary"
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

        CommonDefaultModifiers.showLoader()
        CustomerProfileService().setCustomerProfile(customerProfile: customerProfile) { customerId in
            if customerId != nil {
                UserIdHelper().storeUserId(userId: customerId!)
                UserTypeHelper.setUserType(userType: .Customer)
                LoginDefaultModifiers.signInPatient()
                CommonDefaultModifiers.hideLoader()
            }
        }
    }
}

extension CustomerCreateProfileViewModel : SideBySideCheckBoxDelegate {
    func itemChecked(value: String) {
        self.gender = value
    }
}
