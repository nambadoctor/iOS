//
//  SecretaryViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/28/21.
//

import Foundation

class SecretaryViewModel: ObservableObject {
    @Published var tabSelection:Int = 0
    
    @Published var ServiceProvider:ServiceProviderProfile
    @Published var organisationsAppointments:[ServiceProviderAppointment] = [ServiceProviderAppointment]()
    @Published var organisations:[ServiceProviderOrganisation] = [ServiceProviderOrganisation]()
    @Published var organisationsPatients:[ServiceProviderMyPatientProfile] = [ServiceProviderMyPatientProfile]()
    
    @Published var selectedOrganization:ServiceProviderOrganisation? = nil
    @Published var selectedAppointment:ServiceProviderAppointment? = nil
    
    @Published var noOrganisationsPatients:Bool = false
    @Published var hasAppointments:Bool = false
    @Published var takeToDetailedAppointment:Bool = false
    
    @Published var datePickerVM:DatePickerViewModel = DatePickerViewModel()
    
    init(serviceProvider:ServiceProviderProfile) {
        self.ServiceProvider = serviceProvider
        getCurrentServiceProviderOrganizations()
        self.datePickerVM.datePickerDelegate = self
    }
    
    func updateFCMToken () {
        //update FCM Token
        guard self.ServiceProvider != nil else { return }
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
    
    func getCurrentServiceProviderOrganizations () {
        if self.ServiceProvider.organisationIds != nil {
            ServiceProviderOrganizationService().getServiceProviderSpecificOrganizations(orgIds: self.ServiceProvider.organisationIds!) { organisations in
                if organisations != nil && !organisations!.isEmpty {
                    self.organisations = organisations!
                    self.newOrganisationSelected(organisation: self.organisations[0])
                    self.loadView()
                } else {
                    
                }
            }
        }
    }
    
    func loadView () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Retrieving Appointments")
        self.getPatientsOfOrganizations()
        self.getOrganisationAppointments()
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
    
    func getOrganisationAppointments () {
        ServiceProviderAppointmentService().getOrganisationAppointments(organisationId: selectedOrganization!.organisationId) { appointments in
            if appointments != nil {
                self.organisationsAppointments.removeAll()
                self.organisationsAppointments = appointments!
                self.datePickerVM.setDatesWithAppointments(appointments: appointments!)
                self.dateChanged(selectedDate: self.datePickerVM.selectedDate)
                CommonDefaultModifiers.hideLoader()
            }
            self.checkForEmptyList()
        }
    }
    
    func checkForEmptyList () {
        if organisationsAppointments.isEmpty {
            self.hasAppointments = false
        }
    }
    
    func newOrganisationSelected (organisation:ServiceProviderOrganisation?) {
        self.selectedOrganization = organisation
        
        loadView()
    }
    
}

extension SecretaryViewModel : DatePickerChangedDelegate {
    func dateChanged(selectedDate: Date) {
        self.hasAppointments = checkIfAppointmentExistForDate(date: selectedDate)
    }

    func checkIfAppointmentExistForDate(date:Date) -> Bool {
        var exists:Bool = false
        for appoinment in organisationsAppointments {
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

extension SecretaryViewModel : SelectAppointmentDelegate {
    func selectedAppointment(appointment: ServiceProviderAppointment) {
        self.selectedAppointment = appointment
        self.takeToDetailedAppointment = true
    }
}
