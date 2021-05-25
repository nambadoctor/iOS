//
//  CustomerViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

class CustomerViewModel : ObservableObject {
    @Published var tabSelection:Int = 2
    @Published var customerProfile:CustomerProfile? = nil

    var allAppointments:[CustomerAppointment] = [CustomerAppointment]()
    @Published var upcomingAppointments:[CustomerAppointment] = [CustomerAppointment]()
    @Published var finishedAppointments:[CustomerAppointment] = [CustomerAppointment]()
    @Published var myServiceProviders:[CustomerServiceProviderProfile] = [CustomerServiceProviderProfile]()
    @Published var allServiceProviders:[CustomerServiceProviderProfile] = [CustomerServiceProviderProfile]()
    
    @Published var customerLoggedIn:Bool = false

    @Published var selectedAppointment:CustomerAppointment? = nil
    @Published var takeToDetailedAppointmentView:Bool = false
    
    @Published var imageLoader:ImageLoader? = nil
    
    @Published var addChilVM:AddChildProfileViewModel = AddChildProfileViewModel()
    
    var customerProfileService:CustomerProfileServiceProtocol
    var customerAppointmentService:CustomerAppointmentServiceProtocol
    var customerServiceProviderService:CustomerServiceProviderServiceProtocol

    init(customerProfileService:CustomerProfileServiceProtocol = CustomerProfileService(),
         customerAppointmentService:CustomerAppointmentServiceProtocol = CustomerAppointmentService(),
         customerServiceProviderService:CustomerServiceProviderServiceProtocol = CustomerServiceProviderService()) {
        self.customerProfileService = customerProfileService
        self.customerAppointmentService = customerAppointmentService
        self.customerServiceProviderService = customerServiceProviderService
        initialCustomerFetch()
    }
    
    func initialCustomerFetch () {
        fetchCustomerProfile { retrieved in
            self.customerLoggedIn = true
            self.retrieveCustomerAppointments()
            self.retrieveServiceProviders()
            self.updateFCMToken()

            if !self.customerProfile!.profilePicURL.isEmpty {
                self.imageLoader = ImageLoader(urlString: self.customerProfile!.profilePicURL, { _ in })
            } else {
                self.imageLoader = ImageLoader(urlString: "https://wgsi.utoronto.ca/wp-content/uploads/2020/12/blank-profile-picture-png.png") {_ in}
            }
        }
    }

    func fetchCustomerProfile (completion: @escaping (_ retrieved:Bool)->()) {
        let userId = UserIdHelper().retrieveUserId()
        customerProfileService.getCustomerProfile(customerId: userId) { (customerProfile) in
            if customerProfile != nil {
                self.customerProfile = customerProfile!
                completion(true)
            } else {
                //TODO: handle customer profile null
            }
        }
    }
    
    func sortAppointments (appointments:[CustomerAppointment]) {
        for appointment in appointments {
            if appointment.status == ConsultStateK.Confirmed.rawValue || appointment.status == ConsultStateK.StartedConsultation.rawValue {
                upcomingAppointments.append(appointment)
            } else if appointment.status == ConsultStateK.Finished.rawValue {
                finishedAppointments.append(appointment)
            }
        }

        if upcomingAppointments.count > 0 {
            tabSelection = 1
        }
    }

    func updateFCMToken () {
        //update FCM Token
        guard self.customerProfile != nil else { return
        }
        if !DeviceTokenId.isEmpty {
            self.customerProfile!.appInfo.deviceTokenType = "apn"
            self.customerProfile!.appInfo.deviceToken = DeviceTokenId
            self.updateCustomer()
        }
    }

    func updateCustomer() {
        customerProfileService.setCustomerProfile(customerProfile: self.customerProfile!) { (response) in
            if response != nil {
                print("CUSTOMER UPDATE SUCCESS \(response)")
            }
            CommonDefaultModifiers.hideLoader()
        }
    }

    func retrieveCustomerAppointments () {
        customerAppointmentService.getCustomerAppointments(customerId: self.customerProfile!.customerID) { (customerAppointments) in
            if customerAppointments != nil || customerAppointments?.count != 0 {
                self.allAppointments.removeAll()
                self.upcomingAppointments.removeAll()
                self.finishedAppointments.removeAll()
                self.allAppointments = customerAppointments!
                self.sortAppointments(appointments: customerAppointments!)
                self.getNavigationSelectedAppointment()
                self.setMyDoctors()
            } else {
                //TODO: handle empty or no appointments
            }
        }
    }
    
    func retrieveServiceProviders () {
        customerServiceProviderService.getAllServiceProvider(customerId: customerProfile!.customerID) { (serviceProviders) in
            if serviceProviders != nil || serviceProviders?.count != 0 {
                self.allServiceProviders = serviceProviders!
                self.setMyDoctors()
            } else {
                //TODO: handle empty or no ServiceProviders
            }
        }
    }

    func makeDetailedAppointmentVM() -> CustomerDetailedAppointmentViewModel {
        return CustomerDetailedAppointmentViewModel(appointment: self.selectedAppointment!)
    }
    
    func getNavigationSelectedAppointment () {
        for appointment in upcomingAppointments {
            if cusAutoNav.appointmentId == appointment.appointmentID {
                self.selectedAppointment = appointment
                self.takeToDetailedAppointmentView = true
            }
        }

        for appointment in finishedAppointments {
            if cusAutoNav.appointmentId == appointment.appointmentID {
                self.selectedAppointment = appointment
                self.takeToDetailedAppointmentView = true
            }
        }
    }
    
    func setMyDoctors () {
        if allServiceProviders.isEmpty || allAppointments.isEmpty {
            //cannot get mydoctors
        } else {
            var myServiceProviderIds:[String] = [String]()
            for appointment in allAppointments {
                myServiceProviderIds.append(appointment.serviceProviderID)
            }
            
            for serviceProvider in self.allServiceProviders {
                if myServiceProviderIds.contains(serviceProvider.serviceProviderID) {
                    myServiceProviders.append(serviceProvider)
                }
            }
        }
    }
    
    func addChildCallBack() {
        self.fetchCustomerProfile { _ in }
    }
}

extension CustomerViewModel : CustomerSelectAppointmentDelegate {
    func selected(appointment: CustomerAppointment) {
        self.selectedAppointment = appointment
        self.takeToDetailedAppointmentView = true
    }
}
