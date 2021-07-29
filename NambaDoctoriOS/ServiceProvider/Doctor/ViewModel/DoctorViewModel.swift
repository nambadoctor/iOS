//
//  DoctorViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation

class DoctorViewModel: ObservableObject { 
    @Published var tabSelection:Int = 0
    @Published var ServiceProvider:ServiceProviderProfile!
    @Published var appointments:[ServiceProviderAppointment] = [ServiceProviderAppointment]()
    @Published var availabilities:[ServiceProviderAvailability] = [ServiceProviderAvailability]()
    @Published var myPatients:[ServiceProviderMyPatientProfile] = [ServiceProviderMyPatientProfile]()

    @Published var organisations:[ServiceProviderOrganisation] = [ServiceProviderOrganisation]()
    @Published var organisationsPatients:[ServiceProviderMyPatientProfile] = [ServiceProviderMyPatientProfile]()

    @Published var selectedOrganization:ServiceProviderOrganisation? = nil
    
    @Published var hasAppointments:Bool = false
    @Published var noMyPatients:Bool = false
    @Published var noOrganisationsPatients:Bool = false
    
    @Published var doctorLoggedIn:Bool = false
    @Published var secretaryLoggedIn:Bool = false
    
    @Published var takeToDetailedAppointment:Bool = false
    @Published var selectedAppointment:ServiceProviderAppointment? = nil

    @Published var showEdit:Bool = false
    @Published var editServiceProvider:EditServiceProviderViewModel = EditServiceProviderViewModel()
    @Published var availabilityVM:DoctorAvailabilityViewModel = DoctorAvailabilityViewModel()
    @Published var imageLoader:ImageLoader? = nil
    
    @Published var datePickerVM:DatePickerViewModel = DatePickerViewModel()

    var authenticateService:AuthenticateServiceProtocol
    var serviceProviderServiceCall:ServiceProviderProfileServiceProtocol
    var doctorAppointmentViewModel:ServiceProviderAppointmentServiceProtocol

    init(serviceProvider:ServiceProviderProfile,
        authenticateService:AuthenticateServiceProtocol = AuthenticateService(),
         serviceProviderServiceCall:ServiceProviderProfileServiceProtocol = ServiceProviderProfileService(),
         doctorAptVM:ServiceProviderAppointmentServiceProtocol = ServiceProviderAppointmentService()) {
        self.ServiceProvider = serviceProvider
        self.authenticateService = authenticateService
        self.serviceProviderServiceCall = serviceProviderServiceCall
        self.doctorAppointmentViewModel = doctorAptVM
        
        self.datePickerVM.datePickerDelegate = self
        
        doctorInitCalls()
    }
    
    var serviceProviderName:String {
        return "\(ServiceProvider.firstName ?? "") \(ServiceProvider.lastName ?? "")"
    }
    
    var selectedOrgId:String {
        return self.selectedOrganization != nil ? self.selectedOrganization!.organisationId : ""
    }
    
    var serviceProviderId:String {
        return self.ServiceProvider.serviceProviderID
    }
    
    func doctorInitCalls () {
        self.doctorLoggedIn = true
        self.loadView()
        
        self.updateFCMToken()
        if self.ServiceProvider.profilePictureURL != nil {
            self.imageLoader = ImageLoader(urlString: self.ServiceProvider.profilePictureURL!) { success in }
        }
        self.availabilityVM.getAvailabilities(serviceProviderId: self.ServiceProvider.serviceProviderID)
    }

    func updateFCMToken () {
        //update FCM Token
        guard self.ServiceProvider != nil else { return
        }
        print("UPDATING TOKEN: \(DeviceTokenId)")
        if !DeviceTokenId.isEmpty {
            let appInfoID:String = self.ServiceProvider.applicationInfo?.appInfoID ?? ""
            ServiceProviderUpdateHelper().UpdateFCMToken(appInfoId: appInfoID, serviceProviderId: self.ServiceProvider.serviceProviderID) { response in
                if response != nil {
                    LoggerService().log(eventName: "SUCCESSFULLY UPDATED SERVICE PROVIDER FCM TOKEN")
                }
            }
        }
    }

    func updateServiceProvider () {
        self.ServiceProvider.serviceProviderDeviceInfo = DeviceHelper.getDeviceInfo()
        self.serviceProviderServiceCall.setServiceProvider(serviceProvider: self.ServiceProvider) { (response) in
            if response != nil {
                print("SERVICE PROVIDER UPDATE SUCCESS \(response)")
            }
            CommonDefaultModifiers.hideLoader()
        }
    }
    
    func loadView () {
        self.getServiceProvidersOrganizations()
        
        if selectedOrganization == nil {
            self.retrieveAppointmentsForNambaDoctor ()
            self.getMyFreelancePatients()
        } else {
            self.retrieveAppointmentsForOrganization()
            self.getPatientOfServiceProviderInOrganisation()
            self.getPatientsOfOrganizations()
        }
    }
    
    
    func getServiceProvidersOrganizations () {
        if self.ServiceProvider.organisationIds != nil {
            ServiceProviderOrganizationService().getServiceProviderSpecificOrganizations(orgIds: self.ServiceProvider.organisationIds!) { organisations in
                if organisations != nil && !organisations!.isEmpty {
                    self.organisations = organisations!
                } else {
                    
                }
            }
        }
    }

    func retrieveAppointmentsForNambaDoctor () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Getting your appointments")
        
        doctorAppointmentViewModel.getOrganisationAppointmentsOfServiceProvider(organisationId: self.ServiceProvider.serviceProviderID) { (appointments) in
            if appointments != nil {
                self.appointments.removeAll()
                self.appointments = appointments!
                self.datePickerVM.setDatesWithAppointments(appointments: appointments!)
                self.dateChanged(selectedDate: self.datePickerVM.selectedDate)
                CommonDefaultModifiers.hideLoader()
            }
            self.checkForEmptyList()
            self.getNotificationSelectedAppointment()
        }
    }
    
    func retrieveAppointmentsForOrganization () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Getting appointments")
        doctorAppointmentViewModel.getOrganisationAppointmentsOfServiceProvider(organisationId: self.selectedOrganization!.organisationId) { (appointments) in
            if appointments != nil {
                self.appointments.removeAll()
                self.appointments = appointments!
                self.datePickerVM.setDatesWithAppointments(appointments: appointments!)
                self.dateChanged(selectedDate: self.datePickerVM.selectedDate)
                CommonDefaultModifiers.hideLoader()
            }
            self.checkForEmptyList()
            self.getNotificationSelectedAppointment()
        }
    }

    func getNotificationSelectedAppointment () {
        for appointment in appointments {
            if docAutoNav.appointmentId == appointment.appointmentID {
                self.datePickerVM.selectedDate = Date(milliseconds: appointment.scheduledAppointmentEndTime)
                self.selectedAppointment = appointment
                self.takeToDetailedAppointment = true
            }
        }
    }

    func checkForEmptyList () {
        if appointments.isEmpty {
            self.hasAppointments = false
        }
    }
    
    func getMyFreelancePatients () {
        ServiceProviderCustomerService().GetCustomersOfServiceProviderInOrganisation(organisation: self.ServiceProvider.serviceProviderID, serviceProviderId: self.ServiceProvider.serviceProviderID)  { listOfPatients in
            if listOfPatients != nil && !(listOfPatients?.isEmpty ?? true) {
                self.noMyPatients = false
                self.myPatients = listOfPatients!
            } else {
                self.noMyPatients = true
            }
        }
    }
 
    func getPatientsOfOrganizations () {
        ServiceProviderCustomerService().getCustomersOfOrganisation(organisation: self.selectedOrganization!.organisationId, serviceProviderId: self.ServiceProvider.serviceProviderID) { listOfOrganisationsPatients in
            if listOfOrganisationsPatients != nil && !(listOfOrganisationsPatients?.isEmpty ?? true){
                self.noOrganisationsPatients = false
                self.organisationsPatients = listOfOrganisationsPatients!
            } else {
                self.noOrganisationsPatients = true
            }
        }
    }
    
    func getPatientOfServiceProviderInOrganisation () {
        ServiceProviderCustomerService().GetCustomersOfServiceProviderInOrganisation(organisation: self.selectedOrganization!.organisationId, serviceProviderId: self.ServiceProvider.serviceProviderID)  { listOfPatients in
            if listOfPatients != nil && !(listOfPatients?.isEmpty ?? true) {
                self.noMyPatients = false
                self.myPatients = listOfPatients!
            } else {
                self.noMyPatients = true
            }
        }
    }
    
    func newOrganisationSelected (organisation:ServiceProviderOrganisation?) {
        self.selectedOrganization = organisation
        
        loadView()
    }

    func commitEdits () {
        
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Saving Profile")
        
        if editServiceProvider.imagePickerViewModel.image != nil {
            //upload to firebase and update url here...
        }
        
        if !editServiceProvider.AppointmentDuration.isEmpty {
            ServiceProvider.appointmentDuration = Int32(editServiceProvider.AppointmentDuration)!
        }
        
        if !editServiceProvider.ServiceFee.isEmpty {
            ServiceProvider.serviceFee = Double(editServiceProvider.ServiceFee)!
        }
        
        if !editServiceProvider.TimeIntervalBetweenAppointments.isEmpty {
            ServiceProvider.intervalBetweenAppointment = Int32(editServiceProvider.TimeIntervalBetweenAppointments)!
        }
        
        if !editServiceProvider.FollowUpServiceFee.isEmpty {
            ServiceProvider.followUpServiceFee = Double(editServiceProvider.FollowUpServiceFee)!
        }
        
        updateServiceProvider()
    }

}

extension DoctorViewModel : DatePickerChangedDelegate {
    func dateChanged(selectedDate: Date) {
        self.hasAppointments = checkIfAppointmentExistForDate(date: selectedDate)
    }

    func checkIfAppointmentExistForDate(date:Date) -> Bool {
        var exists:Bool = false
        for appoinment in appointments {
            let order = Calendar.current.compare(date, to: Date(milliseconds: appoinment.scheduledAppointmentStartTime), toGranularity: .day)
            
            if order == .orderedSame {
                exists = true
            }
        }
        return exists
    }
    
    func compareCurrentAppointmentTimeWithSelectedDate (appointment:ServiceProviderAppointment) -> Bool {
        return Helpers.compareDate(timestamp: appointment.scheduledAppointmentStartTime, date2: datePickerVM.selectedDate)
    }
}

extension DoctorViewModel : SelectAppointmentDelegate {
    func selectedAppointment(appointment: ServiceProviderAppointment) {
        self.selectedAppointment = appointment
        self.takeToDetailedAppointment = true
    }
}
