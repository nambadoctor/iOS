//
//  MockMedicineData.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation
@testable import NambaDoctoriOS

class MakeMockMedicine {
    static func getMedicine () -> Medicine {
        return Medicine(id: "", medicineName: "dolo", dosage: "350mg", routeOfAdministration: "Intramuscular", intake: "Twice a day", duration: 10, timings: "0.0,0.5,1.5,0.0", specialInstructions: "spl instructions")
    }
}
