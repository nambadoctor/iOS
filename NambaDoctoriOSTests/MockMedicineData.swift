//
//  MockMedicineData.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation
@testable import NambaDoctoriOS

class MakeMockMedicine {
    static func getMedicine () -> Nambadoctor_V1_MedicineObject {
        return Nambadoctor_V1_MedicineObject.with {
            $0.medicineName = "dolo"
            $0.dosage = "350mg"
            $0.routeOfAdministration = "Intramuscular"
            $0.intake = "Twice a day"
            $0.duration = 10
            $0.timings = "0.0,0.5,1.5,0.0"
            $0.specialInstructions = "spl instructions"
        }
    }
}
