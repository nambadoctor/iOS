//
//  ViewPrescription.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import SwiftUI

struct ViewPrescription: View {
    
    @ObservedObject var prescriptionVM: ServiceRequestViewModel

    var body: some View {
        VStack {
            if prescriptionVM.errorInRetrievingPrescription {
                Text("Prescription could not be retrieved")
            } else if prescriptionVM.serviceRequest == nil {
                Indicator()
            } else {
                //ViewPrescriptionForm
            }
        }
    }
    
//    var ViewPrescriptionForm : some View {
//        Form {
//            //Section(header: Text("History")) { Text(prescriptionVM.serviceRequest.history) }
//            Section(header: Text("Examination")) { Text(prescriptionVM.serviceRequest.examination) }
//            Section(header: Text("Diagnosis")) { Text(prescriptionVM.serviceRequest.diagnosis.name) }
//            Section(header: Text("Advise")) { Text(prescriptionVM.serviceRequest.advice) }
//            //Section(header: Text("Patient Allergies")) { Text(prescriptionVM.patientAllergies) }
//
//            Section(header: Text("Investigations")) {
//                if !prescriptionVM.InvestigationsVM.investigations.isEmpty {
//                    ForEach(Array(prescriptionVM.InvestigationsVM.investigations.enumerated()), id: \.0) { i, _ in
//                        if !prescriptionVM.InvestigationsVM.investigations[i].isEmpty {
//                            HStack {
//                                Text("\(self.prescriptionVM.InvestigationsVM.investigations[i])")
//                            }
//                        }
//                    }
//                } else {
//                    Text("No Investigations")
//                }
//            }
//
//            Section(header: Text("Prescriptions")) {
//                if prescriptionVM.hasMedicines {
//                    MedicineView(medicineVM: prescriptionVM.MedicineVM)
//                } else {
//                    Text("No Medicines Prescribed")
//                }
//            }
//
////            Section(header: Text("Follow Up")) {
////                if prescriptionVM.FollowUpVM.needFollowUp {
////                    Text("In: \(prescriptionVM.FollowUpVM.validityDaysDisplay)")
////                    Text("Fee: \(prescriptionVM.FollowUpVM.nextFeeDisplay)")
////                } else {
////                    Text("No Follow up")
////                }
////            }
//
//        }
//    }
}
