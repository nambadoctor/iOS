//
//  MockFollowUpAptData.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation
@testable import NambaDoctoriOS

let mockFollowUpJSON = "{\"PatientId\":\"rqvlneN3cUZrIeSnq1OfeAciEkw2\",\"appointmentId\":\"001b874f-3f00-49f0-bfd0-8bf783c37ae0\",\"createdDateTime\":\"2020-12-28 16:09:23.187\",\"doctorId\":\"jhsY3OMj6Oe8oswMUiWnTZqAk7q1\",\"nextAppointmentFee\":500,\"validityDays\":20}"

class MakeMockFollowUp {
    static func getFollowUp () -> PatientFollowUpObj {
        let data = mockFollowUpJSON.data(using: .utf8)!
        let mockFollowUp = try? JSONDecoder().decode(PatientFollowUpObj.self, from: data)
        return mockFollowUp!
    }
}

