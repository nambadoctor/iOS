//
//  AddPatientViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/24/21.
//

import Foundation

class AddPatientViewModel: ObservableObject {
    @Published var firstName:String = ""
    @Published var lastName:String = ""
    @Published var gender:String = ""
    @Published var age:String = ""
    
    @Published var scheduleAppointmentVM:ScheduleAppointmentForPatientViewModel

    @Published var scheduleAppointmentToggle:Bool = false
    @Published var myPatientProfile:ServiceProviderMyPatientProfile = ServiceProviderMyPatientProfile(CustomerId: "", IsChild: false, CareTakerId: "", Age: "", Gender: "", Name: "")
    
    @Published var finished:Bool = false
    
    var organisation:ServiceProviderOrganisation?
    var serviceProvider:ServiceProviderProfile
    
    var phoneNumber:PhoneNumberObj = PhoneNumberObj()

    init(organisation:ServiceProviderOrganisation?, serviceProvider:ServiceProviderProfile) {
        self.organisation = organisation
        self.serviceProvider = serviceProvider
        self.scheduleAppointmentVM = ScheduleAppointmentForPatientViewModel(organisation: organisation, serviceProvider: serviceProvider, customer: ServiceProviderMyPatientProfile(CustomerId: "", IsChild: false, CareTakerId: "", Age: "", Gender: "", Name: ""), finishedCallback: nil)
        
        self.scheduleAppointmentVM.customer = myPatientProfile
        self.scheduleAppointmentVM.finishedCallback = finishedCallback
    }
    
    var customerName : String {
        return "\(firstName) \(lastName)"
    }
    
    func finishedCallback() {
        finished = true
    }
    
    func confirm (completion: @escaping (_ success:Bool)->()) {
        register { customerId in
            if customerId != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func register (completion: @escaping (_ customerId:String?)->()) {
        let phoneNumberObj = PhoneNumber(countryCode: self.phoneNumber.countryCode, number: self.phoneNumber.number.text, type: "Primary", phoneNumberID: "")
        
        let phoneNumbers:[PhoneNumber] = [phoneNumberObj]
        
        let appInfoObj = CustomerAppInfo(authID: AuthenticateService().getUserId(),
                                         authType: "Firebase",
                                         deviceToken: DeviceTokenId,
                                         appInfoID: "",
                                         deviceTokenType: "apn")
        
        let deviceInfoObj = DeviceHelper.getDeviceInfo()

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
                                              primaryServiceProviderID: self.serviceProvider.serviceProviderID,
                                              Allergies: [CustomerAllergy](),
                                              MedicalHistories: [CustomerMedicalHistory](),
                                              lastModifiedDate: Date().millisecondsSince1970,
                                              createdDate: Date().millisecondsSince1970,
                                              children: [CustomerChildProfile](),
                                              customerProviderDeviceInfo: deviceInfoObj,
                                              primaryOrganisationId: self.organisation?.organisationId ?? "")

        CommonDefaultModifiers.showLoader(incomingLoadingText: "Creating Customer Profile")
        CustomerProfileService().setCustomerProfile(customerProfile: customerProfile) { customerId in
            if customerId != nil {
                self.scheduleAppointmentVM.customer = ServiceProviderMyPatientProfile(CustomerId: customerId!, IsChild: false, CareTakerId: "", Age: self.age, Gender: self.gender, Name: self.customerName)
                CommonDefaultModifiers.hideLoader()
                completion(customerId!)
            } else {
                completion(nil)
            }
        }
    }
}

extension AddPatientViewModel : SideBySideCheckBoxDelegate {
    func itemChecked(value: String) {
        self.gender = value
    }
}
