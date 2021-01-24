//
//  MockAppointmentData.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation
@testable import NambaDoctoriOS

var mockAppointmentJson = "{\"createdDateTime\": \"2020-12-28 16:09:23.187\",\"doctorId\": \"jhsY3OMj6Oe8oswMUiWnTZqAk7q1\",\"doctorName\": \"Surya\",\"id\": \"001b874f-3f00-49f0-bfd0-8bf783c37ae0\",\"matchType\": \"Patient Chosen\",\"patientName\": \"Jacob\",\"paymentStatus\": \"Not Paid\",\"preferredLanguage\": \"english\",\"problemDetails\": \"Referral\",\"requestedBy\": \"rqvlneN3cUZrIeSnq1OfeAciEkw2\",\"slotDateTime\": \"2020-12-30 08:00:00.000\",\"slotId\": \"4\",\"status\": \"Cancelled\"}"

class MakeMockAppointment {
    static func getAppointment () -> Appointment {
        let data = mockAppointmentJson.data(using: .utf8)!
        let mockAppointment = try? JSONDecoder().decode(Appointment.self, from: data)
        return mockAppointment!
    }
}
