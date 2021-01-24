//
//  MockMedicineData.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation
@testable import NambaDoctoriOS

let mockMedicineJSON = "{\"dosage\":\"350mg\",\"intake\":\"Twice a day\",\"medicineName\":\"dolo\",\"numOfDays\":10,\"routeOfAdmission\":\"Intramuscular\",\"splInstructions\":\"AnyTime\",\"timings\":\"0.0,0.5,1.5,0.0\"}"

class MakeMockMedicine {
    static func getMedicine () -> Medicine {
        let data = mockMedicineJSON.data(using: .utf8)!
        let mockMedicine = try? JSONDecoder().decode(Medicine.self, from: data)
        return mockMedicine!
    }
}
