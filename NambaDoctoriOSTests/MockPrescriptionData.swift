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
    static func getPrescription () -> Nambadoctor_V1_PrescriptionObject {
        return Nambadoctor_V1_PrescriptionObject.with {
            $0.id = ""
            $0.appointmentID = ""
            $0.history = "history"
            $0.examination = "examination"
            $0.diagnosis = "diagnosis"
            $0.diagnosisType = "definitive"
            $0.investigations = Nambadoctor_V1_InvestigationList.with {
                $0.investigation = ["inv 1", "inv 2"]
            }
            $0.advice = "advice"
            $0.doctorID = "jhsY3OMj6Oe8oswMUiWnTZqAk7q1"
            $0.patientID = "patientId"
            $0.createdDateTime = 0
            $0.medicines = []
        }
    }
}
