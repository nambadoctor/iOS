//
//  DoctorViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation

class DoctorViewModel: ObservableObject {
    @Published private var doctor:Nambadoctor_V1_DoctorResponse = Nambadoctor_V1_DoctorResponse()
    @Published var upcomingAppointments:[Nambadoctor_V1_AppointmentObject] = [Nambadoctor_V1_AppointmentObject]()
    @Published var finishedAppointments:[Nambadoctor_V1_AppointmentObject] = [Nambadoctor_V1_AppointmentObject]()
    
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
        }
    }
}
