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
    
    @Published var scheduleAppointmentToggle:Bool = false
    @Published var killView:Bool = false

    @Published var availabilityVM:AvailabilitySelectorViewModel
    @Published var fee:Double
    @Published var followup:Int32 = 0
    
    @Published var customerVitals:ServiceProviderCustomerVitals = ServiceProviderCustomerVitals(BloodPressure: "", BloodSugar: "", Height: "", Weight: "", MenstrualHistory: "", ObstetricHistory: "", IsSmoker: false, IsAlcoholConsumer: false)

    var organisation:ServiceProviderOrganisation?
    var serviceProvider:ServiceProviderProfile
    
    var phoneNumber:PhoneNumberObj = PhoneNumberObj()
    
    init(organisation:ServiceProviderOrganisation?, serviceProvider:ServiceProviderProfile) {
        self.organisation = organisation
        self.serviceProvider = serviceProvider
        
        self.availabilityVM = AvailabilitySelectorViewModel(serviceProviderID: serviceProvider.serviceProviderID)
        self.fee = serviceProvider.serviceFee ?? 0
    }
    
    var customerName : String {
        return "\(firstName) \(lastName)"
    }
    
    func confirm () {
        register { customerId in
            if customerId != nil {
                if self.scheduleAppointmentToggle {

                    guard self.availabilityVM.selectedDate != 0, self.availabilityVM.selectedTime != 0 else {
                        CustomerAlertHelpers().pleaseChooseTimeandDateAlert { _ in }
                        return
                    }
                    
                    self.bookAppointment(customerId: customerId!) { appointmentId in
                        self.killView = true
                    }
                } else {
                    self.killView = true
                }
            }
        }
    }
    
    func bookAppointment (customerId:String, completion: @escaping (_ success:Bool?)->()) {
        ServiceProviderAppointmentService().setAppointment(appointment: makeAppointment(customerId: customerId)) { appointmentId in
            if appointmentId != nil {
                ServiceProviderServiceRequestService().setServiceRequest(serviceRequest: self.makeServiceRequest(customerId: customerId, appointmentId: appointmentId!)) { serviceRequestId in
                    if serviceRequestId != nil {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            } else {
                completion(false)
            }
        }
    }
    
    func makeAppointment (customerId:String) -> ServiceProviderAppointment {
        
        let cancellation = ServiceProviderCancellation(ReasonName: "", CancelledTime: Date().millisecondsSince1970, CancelledBy: "", CancelledByType: "", Notes: "")
        
        self.availabilityVM.setSlot()
        
        return ServiceProviderAppointment(appointmentID: "",
                                          serviceRequestID: "",
                                          parentAppointmentID: "",
                                          customerID: customerId,
                                          serviceProviderID: self.serviceProvider.serviceProviderID,
                                          requestedBy: self.serviceProvider.serviceProviderID,
                                          serviceProviderName: "\(self.serviceProvider.firstName ?? "") \(self.serviceProvider.lastName ?? "")",
                                          customerName: customerName,
                                          isBlockedByServiceProvider: false,
                                          status: ConsultStateK.Confirmed.rawValue,
                                          serviceFee: self.fee,
                                          followUpDays: followup,
                                          isPaid: fee == 0 ? true : false,
                                          scheduledAppointmentStartTime: self.availabilityVM.selectedSlot?.startDateTime ?? 0,
                                          scheduledAppointmentEndTime: self.availabilityVM.selectedSlot?.endDateTime ?? 0,
                                          actualAppointmentStartTime: 0,
                                          actualAppointmentEndTime: 0,
                                          createdDateTime: Date().millisecondsSince1970,
                                          lastModifiedDate: Date().millisecondsSince1970,
                                          noOfReports: 0,
                                          cancellation: cancellation,
                                          childId: "",
                                          paymentType: PaymentTypeEnum.PostPay.rawValue,
                                          appointmentVerification: nil,
                                          organisationId: organisation?.name ?? "",
                                          organisationName: organisation?.organisationId ?? "")
    }
    
    func makeServiceRequest (customerId:String, appointmentId:String) -> ServiceProviderServiceRequest {

        let emptyDiagnosis = ServiceProviderDiagnosis(name: "", type: "")
        let emptyAllergy = ServiceProviderCustomerAllergy(AllergyId: "", AllergyName: "", AppointmentId: "", ServiceRequestId: "")
        let emptyMedicalHistory = ServiceProviderCustomerMedicalHistory(MedicalHistoryId: "", MedicalHistoryName: "", PastMedicalHistory: "", MedicationHistory: "", AppointmentId: "", ServiceRequestId: "")
        
        return ServiceProviderServiceRequest(serviceRequestID: "",
                                                    reason: "",
                                                    serviceProviderID: serviceProvider.serviceProviderID,
                                                    appointmentID: appointmentId,
                                                    examination: "",
                                                    diagnosis: emptyDiagnosis,
                                                    investigations: [String](),
                                                    advice: "",
                                                    createdDateTime: Date().millisecondsSince1970,
                                                    lastModifiedDate: Date().millisecondsSince1970,
                                                    customerID: customerId,
                                                    allergy: emptyAllergy,
                                                    medicalHistory: emptyMedicalHistory,
                                                    childId: "",
                                                    customerVitals: customerVitals,
                                                    organisationId: organisation?.organisationId ?? "")
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
