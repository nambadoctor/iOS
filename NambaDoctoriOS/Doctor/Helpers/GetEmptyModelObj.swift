//
//  GetEmptyModelObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class GetEmptyModelObj {
    func getFreshPrescription () -> Prescription {
        return Prescription(additionalNotes: "", appointmentId: "", clinicalSummary: "", diagnosis: "", diagnosisType: "", doctorId: "", history: "", medicine: [Medicine](), planInfo: "", referals: "")
    }
    
    func medicineObj () -> Medicine {
        return Medicine(dosage: "", intake: "", medicineName: "", numOfDays: 0, splInstructions: "", routeOfAdmission: "", timings: "")
    }
}
