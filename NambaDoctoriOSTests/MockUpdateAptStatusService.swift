//
//  MockUpdateAptService.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 21/01/21.
//

@testable import NambaDoctoriOS

class MockUpdateAptStatusService: UpdateAppointmentStatusProtocol {
    
    var updateCancelSuccess:Bool = false
    var updateStartConsultationSuccess:Bool = false
    var updateToFinishedSuccess:Bool = false
    var updateToFinishedAppointmentSuccess:Bool = false
    
    func getParams(appointmentId: String, status: String) -> [String : Any] {
        let parameters: [String: Any] = [
            "id":appointmentId,
            "status":status
        ]

        return parameters
    }
    
    func toCancelled(appointmentId: String, completion: @escaping (Bool) -> ()) {
        completion(updateCancelSuccess)
    }
    
    func updateToStartedConsultation(appointmentId: String, completion: @escaping (Bool) -> ()) {
        completion(updateStartConsultationSuccess)
    }
    
    func updateToFinished(appointmentId: String, completion: @escaping (Bool) -> ()) {
        completion(updateToFinishedSuccess)
    }

    func updateToFinishedAppointment(appointmentId: String, completion: @escaping (Bool) -> ()) {
        completion(updateToFinishedAppointmentSuccess)
    }
}
