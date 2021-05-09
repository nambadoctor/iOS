//
//  CustomerViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

class CustomerViewModel : ObservableObject {
    @Published var customerProfile:CustomerProfile? = nil
    @Published var appointments:[CustomerAppointment]? = nil
    @Published var serviceProviders:[CustomerServiceProviderProfile]? = nil
    
    @Published var customerLoggedIn:Bool = false
    
    @Published var selectedAppointment:CustomerAppointment? = nil
    @Published var takeToDetailedAppointmentView:Bool = false
    
    var customerProfileService:CustomerProfileServiceProtocol
    var customerAppointmentService:CustomerAppointmentServiceProtocol
    var customerServiceProviderService:CustomerServiceProviderServiceProtocol

    init(customerProfileService:CustomerProfileServiceProtocol = CustomerProfileService(),
         customerAppointmentService:CustomerAppointmentServiceProtocol = CustomerAppointmentService(),
         customerServiceProviderService:CustomerServiceProviderServiceProtocol = CustomerServiceProviderService()) {
        self.customerProfileService = customerProfileService
        self.customerAppointmentService = customerAppointmentService
        self.customerServiceProviderService = customerServiceProviderService
    
        self.fetchCustomerProfile()
    }

    func fetchCustomerProfile () {
        let userId = UserIdHelper().retrieveUserId()
        customerProfileService.getCustomerProfile(customerId: userId) { (customerProfile) in
            if customerProfile != nil {
                self.customerProfile = customerProfile!
                self.customerLoggedIn = true
                self.retrieveCustomerAppointments()
                self.retrieveServiceProviders()
                self.updateFCMToken()
            } else {
                //TODO: handle customer profile null
            }
        }
    }
    
    func updateFCMToken () {
        //update FCM Token
        guard self.customerProfile != nil else { return
        }
        if !DeviceTokenId.isEmpty {
            self.customerProfile!.appInfo.deviceToken = DeviceTokenId
            self.updateCustomer()
        }
    }

    func updateCustomer() {
        customerProfileService.setCustomerProfile(customerProfile: self.customerProfile!) { (response) in
            if response != nil {
                print("SERVICE PROVIDER UPDATE SUCCESS \(response)")
            }
            CommonDefaultModifiers.hideLoader()
        }
    }

    func retrieveCustomerAppointments () {
        customerAppointmentService.getCustomerAppointments(customerId: self.customerProfile!.customerID) { (customerAppointments) in
            if customerAppointments != nil || customerAppointments?.count != 0 {
                self.appointments = customerAppointments!
                self.getNavigationSelectedAppointment()
            } else {
                //TODO: handle empty or no appointments
            }
        }
    }
    
    func retrieveServiceProviders () {
        customerServiceProviderService.getAllServiceProvider(customerId: customerProfile!.customerID) { (serviceProviders) in
            if serviceProviders != nil || serviceProviders?.count != 0 {
                self.serviceProviders = serviceProviders!
            } else {
                //TODO: handle empty or no ServiceProviders
            }
        }
    }

    func makeDetailedAppointmentVM() -> CustomerDetailedAppointmentViewModel {
        return CustomerDetailedAppointmentViewModel(appointment: self.selectedAppointment!)
    }
    
    func getNavigationSelectedAppointment () {
        for appointment in appointments! {
            if cusAutoNav.appointmentId == appointment.appointmentID {
                self.selectedAppointment = appointment
                self.takeToDetailedAppointmentView = true
            }
        }
    }
}

extension CustomerViewModel : CustomerSelectAppointmentDelegate {
    func selected(appointment: CustomerAppointment) {
        self.selectedAppointment = appointment
        self.takeToDetailedAppointmentView = true
    }
}
