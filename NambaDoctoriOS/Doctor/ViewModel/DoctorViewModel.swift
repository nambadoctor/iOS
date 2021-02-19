//
//  DoctorViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation

class DoctorViewModel: ObservableObject {
    @Published private var doctor:Doctor = MakeEmptyDoctor()
    @Published var upcomingAppointments:[Appointment] = [Appointment]()
    @Published var finishedAppointments:[Appointment] = [Appointment]()
    
    @Published var noUpcomingAppointments:Bool = false
    @Published var noFinishedAppointments:Bool = false
    
    @Published var doctorLoggedIn:Bool = false
    
    var authenticateService:AuthenticateServiceProtocol
    var doctorAppointmentViewModel:DoctorAppointmentViewModelProtocol

    init(authenticateService:AuthenticateServiceProtocol = AuthenticateService(),
         doctorAptVM:DoctorAppointmentViewModelProtocol = DoctorAppointmentViewModel()) {
        self.authenticateService = authenticateService
        self.doctorAppointmentViewModel = doctorAptVM
        fetchDoctor()
        retrieveAppointments()
    }
    
    func fetchDoctor () {
        GetDocObject().fetchDoctor(userId: authenticateService.getUserId()) { (docObj) in
            self.doctor = docObj
            self.doctorLoggedIn = true
        }
    }

    var authTokenId:String? {
        guard !AuthTokenId.isEmpty else {
            RetrieveAuthTokenId.getToken { _ in }
            return nil
        }
        
        return AuthTokenId
    }
    
    var fcmTokenId:String? {
        guard !FCMTokenId.isEmpty else {
            RetrieveAuthTokenId.getToken { _ in }
            return nil
        }
        return AuthTokenId
    }
    
    func retrieveAppointments () {
        doctorAppointmentViewModel.retrieveDocAppointmentList { (appointments) in
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
