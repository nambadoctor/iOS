//
//  DoctorViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation

class DoctorViewModel: ObservableObject {
    @Published private var doctor:ServiceProviderProfile!
    @Published var appointments:[ServiceProviderAppointment] = [ServiceProviderAppointment]()
    
    @Published var noAppointments:Bool = false
    @Published var doctorLoggedIn:Bool = false
    
    var authenticateService:AuthenticateServiceProtocol
    var serviceProviderServiceCall:ServiceProviderGetSetServiceCallProtocol
    var doctorAppointmentViewModel:AppointmentGetSetServiceCallProtocol

    init(authenticateService:AuthenticateServiceProtocol = AuthenticateService(),
         serviceProviderServiceCall:ServiceProviderGetSetServiceCallProtocol = ServiceProviderGetSetServiceCall(),
         doctorAptVM:AppointmentGetSetServiceCallProtocol = AppointmentGetSetServiceCall()) {
        self.authenticateService = authenticateService
        self.serviceProviderServiceCall = serviceProviderServiceCall
        self.doctorAppointmentViewModel = doctorAptVM
        fetchDoctor()
    }
    
    func fetchDoctor () {
        let userId = authenticateService.getUserId()
        serviceProviderServiceCall.getServiceProvider(serviceProviderId: userId) { (serviceProviderObj) in
            if serviceProviderObj != nil {
                self.doctor = serviceProviderObj!
                self.doctorLoggedIn = true
                self.retrieveAppointments()
            }
        }
    }

    var authTokenId:String? {
        return doctor.applicationInfo.authID
    }
    
    var fcmTokenId:String? {
        return doctor.applicationInfo.deviceToken
    }
    
    func retrieveAppointments () {
        doctorAppointmentViewModel.getDocAppointments(serviceProviderId: doctor.serviceProviderID) { (appointments) in
            if appointments != nil {
                self.appointments = appointments!
            }
            self.checkForEmptyList()
        }
    }
    
    func checkForEmptyList () {
        if appointments.isEmpty {
            self.noAppointments = true
        }
    }
    
    func refreshAppointments () {
        self.appointments.removeAll()
        self.retrieveAppointments()
    }
}
