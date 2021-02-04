//
//  ViewPrescription.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import SwiftUI

struct ViewPrescription: View {
    
    @ObservedObject var prescriptionVM: PrescriptionViewModel

    var body: some View {
        Form {
            Section(header: Text("History")) { Text(prescriptionVM.prescription.history) }
            Section(header: Text("Examination")) { Text(prescriptionVM.prescription.examination) }
            Section(header: Text("Diagnosis")) { Text(prescriptionVM.prescription.diagnosis) }
            Section(header: Text("Advise")) { Text(prescriptionVM.prescription.advice) }
            Section(header: Text("Patient Allergies")) { Text(prescriptionVM.patientAllergies) }

            Section(header: Text("Investigations")) {
                if !prescriptionVM.InvestigationsVM.investigations.isEmpty {
                    ForEach(Array(prescriptionVM.InvestigationsVM.investigations.enumerated()), id: \.0) { i, _ in
                        if !prescriptionVM.InvestigationsVM.investigations[i].isEmpty {
                            HStack {
                                Text("\(self.prescriptionVM.InvestigationsVM.investigations[i])")
                            }
                        }
                    }
                } else {
                    Text("No Investigations")
                }
            }

            Section(header: Text("Prescriptions")) {
                if prescriptionVM.hasMedicines {
                    MedicineView(medicineVM: prescriptionVM.MedicineVM)
                } else {
                    Text("No Medicines Prescribed")
                }
            }

            Section(header: Text("Follow Up")) {
                if prescriptionVM.FollowUpVM.needFollowUp {
                    Text("In: \(prescriptionVM.FollowUpVM.validityDaysDisplay)")
                    Text("Fee: \(prescriptionVM.FollowUpVM.nextFeeDisplay)")
                } else {
                    Text("No Follow up")
                }
            }

        }
        .onAppear() {prescriptionVM.prescriptionViewOnAppear()}
    }
}
