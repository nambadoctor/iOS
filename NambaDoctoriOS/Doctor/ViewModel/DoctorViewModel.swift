//
//  DoctorViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation

class DoctorViewModel: ObservableObject {
    @Published private var doctor:ServiceProviderProfile!
    @Published var upcomingAppointments:[ServiceProviderAppointment] = [ServiceProviderAppointment]()
    @Published var finishedAppointments:[ServiceProviderAppointment] = [ServiceProviderAppointment]()
    
    @Published var noUpcomingAppointments:Bool = false
    @Published var noFinishedAppointments:Bool = false

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
            guard appointments != nil else {return}
            for appointment in appointments! {
                switch CheckAppointmentStatus.checkStatus(appointmentStatus: appointment.status) {
                case .Confirmed, .FinishedAppointment, .StartedConsultation:
                    self.upcomingAppointments.append(appointment)
                case .Finished:
                    self.finishedAppointments.append(appointment)
                }
            }
            self.checkForEmptyList()
        }
    }
    
    func checkForEmptyList () {
        if upcomingAppointments.isEmpty {
            self.noUpcomingAppointments = true
        }
        
        if finishedAppointments.isEmpty {
            self.noFinishedAppointments = true
        }
    }
    
    func refreshAppointments () {
        self.upcomingAppointments.removeAll()
        self.finishedAppointments.removeAll()
        self.retrieveAppointments()
    }
}
