//
//  ScheduleAppointmentForPatientViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/25/21.
//

import Foundation

class ScheduleAppointmentForPatientViewModel : ObservableObject {
    @Published var availabilityVM:AvailabilitySelectorViewModel

    @Published var scheduleAppointmentToggle:Bool = false
    @Published var killView:Bool = false

    @Published var fee:Double
    @Published var followup:Int32 = 0
    @Published var isInPersonAppointment:Bool = false
    
    @Published var customerVitalsViewModel:CustomerVitalsEntryViewModel = CustomerVitalsEntryViewModel()
    @Published var reportUploadVM:ServiceProviderReportsEntryViewModel = ServiceProviderReportsEntryViewModel()
    
    var finishedCallback:(()->())?

    var organisation:ServiceProviderOrganisation?
    var serviceProvider:ServiceProviderProfile
    var customer:ServiceProviderMyPatientProfile
    
    init(organisation:ServiceProviderOrganisation?, serviceProvider:ServiceProviderProfile, customer:ServiceProviderMyPatientProfile, finishedCallback: (()->())?) {
        self.organisation = organisation
        self.serviceProvider = serviceProvider
        self.customer = customer
        self.fee = serviceProvider.serviceFee ?? 0
        self.finishedCallback = finishedCallback
        self.availabilityVM = AvailabilitySelectorViewModel(serviceProviderID: serviceProvider.serviceProviderID, slotSelected: nil, organisationId: self.organisation?.organisationId ?? "")
    }
    
    func bookAppointment (completion: @escaping (_ success:Bool?)->()) {
        
        guard availabilityVM.selectedDate != 0, availabilityVM.selectedTime != 0 else {
            CustomerAlertHelpers().pleaseChooseTimeandDateAlert { _ in }
            return
        }

        CommonDefaultModifiers.showLoader(incomingLoadingText: "Scheduling Appointment")
        var appointment = makeAppointment(customerId: self.customer.CustomerId)
        ServiceProviderAppointmentService().setAppointment(appointment: appointment) { appointmentId in
            if appointmentId != nil {
                appointment.appointmentID = appointmentId!
                ServiceProviderServiceRequestService().setServiceRequest(serviceRequest: self.makeServiceRequest(customerId: self.customer.CustomerId, appointmentId: appointmentId!)) { serviceRequestId in
                    if serviceRequestId != nil {
                        appointment.serviceRequestID = serviceRequestId!
                        CommonDefaultModifiers.hideLoader()
                        if self.reportUploadVM.imagesToUpload.isEmpty {
                            if self.finishedCallback != nil {
                                self.finishedCallback!()
                            }
                            completion(true)
                        } else {
                            self.reportUploadVM.setReports(appointment: appointment) { success in
                                if success {
                                    self.callFinished()
                                    completion(true)
                                }
                            }
                        }
                    } else {
                        completion(false)
                    }
                }
            } else {
                completion(false)
            }
        }
    }
    
    func callFinished () {
        if self.finishedCallback != nil {
            self.finishedCallback!()
        }
    }
    
    func makeAppointment (customerId:String) -> ServiceProviderAppointment {
        self.availabilityVM.setSlot()
        
        return ServiceProviderAppointment(appointmentID: "",
                                          serviceRequestID: "",
                                          parentAppointmentID: "",
                                          customerID: customerId,
                                          serviceProviderID: self.serviceProvider.serviceProviderID,
                                          requestedBy: self.serviceProvider.serviceProviderID,
                                          serviceProviderName: "\(self.serviceProvider.firstName ?? "") \(self.serviceProvider.lastName ?? "")",
                                          customerName: customer.Name,
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
                                          cancellation: nil,
                                          childId: "",
                                          paymentType: PaymentTypeEnum.PostPay.rawValue,
                                          appointmentVerification: nil,
                                          organisationId: organisation?.organisationId ?? "",
                                          organisationName: organisation?.name ?? "",
                                          IsInPersonAppointment: false,
                                          AddressId: self.availabilityVM.selectedSlot?.addressId ?? "",
                                          AppointmentTransfer: nil)
    }
    
    func makeServiceRequest (customerId:String, appointmentId:String) -> ServiceProviderServiceRequest {

        let emptyDiagnosis = ServiceProviderDiagnosis(name: "", type: "")
        let emptyAllergy = ServiceProviderCustomerAllergy(AllergyId: "", AllergyName: "", AppointmentId: "", ServiceRequestId: "")
        let emptyMedicalHistory = ServiceProviderCustomerMedicalHistory(MedicalHistoryId: "", MedicalHistoryName: "", PastMedicalHistory: "", MedicationHistory: "", AppointmentId: "", ServiceRequestId: "")
        customerVitalsViewModel.confirmVitals()
        
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
                                                    customerVitals: customerVitalsViewModel.customerVitals,
                                                    organisationId: organisation?.organisationId ?? "", additionalEntryFields: makeEmptyAdditionalEntryFields())
    }
    
    func selectSlotOption() {
        
    }
}
