//
//  MockPrescriptionData.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation
@testable import NambaDoctoriOS

let mockPrescriptionJson = "{\"additionalNotes\": \"additional-notes\",\"appointmentId\": \"001b874f-3f00-49f0-bfd0-8bf783c37ae0\",\"clinicalSummary\": \"clinical-summary\",\"diagnosis\": \"diagnosis\",\"diagnosisType\": \"diagnosis-type\",\"doctorId\": \"jhsY3OMj6Oe8oswMUiWnTZqAk7q1\",\"history\": \"history\",\"planInfo\": \"plan-info\",\"referals\": \"referals\",\"medicine\": null}"

class MakeMockPrescription {
    static func getPrescription () -> Prescription {
        return Prescription(id: "", appointmentID: "", history: "", examination: "", diagnosis: "", diagnosisType: "", investigations: [""], advice: "", doctorID: "", patientID: "", createdDateTime: 0, medicines: [Medicine]())
    }
}
