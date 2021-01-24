//
//  MockRetrievePrescriptionService.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 22/01/21.
//

@testable import NambaDoctoriOS

class MockRetrievePrescriptionService : RetrievePrescriptionForAppointmentProtocol {

    var retrievePrescriptionSuccess:Bool = false

    func getPrescription(appointmentId: String, _ completion: @escaping ((Prescription?) -> ())) {
        if retrievePrescriptionSuccess {
            completion(MakeMockPrescription.getPrescription())
        } else {
            completion(nil)
        }
    }
}
