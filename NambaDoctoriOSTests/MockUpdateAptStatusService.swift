//
//  MockUpdateAptService.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 21/01/21.
//

@testable import NambaDoctoriOS

class MockUpdateAptStatusService: UpdateAppointmentStatusProtocol {
    
    var makeAppointmentUpdate:Bool = false
    var updateCancelSuccess:Bool = false
    var updateStartConsultationSuccess:Bool = false
    var updateToFinishedSuccess:Bool = false
    var updateToFinishedAppointmentSuccess:Bool = false
    
    func makeAppointmentUpdate (appointment:Nambadoctor_V1_AppointmentObject,
                                completion: @escaping (_ updated:Bool)->()) {
        completion(makeAppointmentUpdate)
    }
    
    func toCancelled(appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (Bool) -> ()) {
        completion(updateCancelSuccess)
    }
    
    func updateToStartedConsultation(appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (Bool) -> ()) {
        completion(updateStartConsultationSuccess)
    }
    
    func updateToFinished(appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (Bool) -> ()) {
        completion(updateToFinishedSuccess)
    }

    func updateToFinishedAppointment(appointment:inout Nambadoctor_V1_AppointmentObject, completion: @escaping (Bool) -> ()) {
        completion(updateToFinishedAppointmentSuccess)
    }
}
