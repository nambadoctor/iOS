//
//  DoctorViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation

class DoctorViewModel: ObservableObject {
    @Published private var doctor:Doctor
    @Published var upcomingAppointments:[Appointment] = [Appointment]()
    @Published var finishedAppointments:[Appointment] = [Appointment]()

    init() {
        doctor = LocalDecoder.decode(modelType: Doctor.self, from: LocalEncodingK.userObj.rawValue)!
        self.retrieveAppointments()
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
    
    func storeDocObj() {
        LocalEncoder.encode(payload: doctor, destination: LocalEncodingK.userObj.rawValue)
    }

    func retrieveDocObj() {
        doctor = LocalDecoder.decode(modelType: Doctor.self, from: LocalEncodingK.userObj.rawValue)!
    }

    func retrieveAppointments () {
        DoctorAppointmentViewModel.retrieveDocAppointmentList { (appointments) in
            for appointment in appointments {
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
