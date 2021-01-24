//
//  BasicDetailsEntryView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import SwiftUI

struct BasicDetailsEntryView: View {
    @ObservedObject var prescriptionVM:PrescriptionViewModel

    var body: some View {
        Section(header: Text("History")) {
            TextEditor(text: $prescriptionVM.prescription.history).frame(width: UIScreen.main.bounds.width-60, height: 100)
        }

        Section(header: Text("Examination")) {
            TextEditor(text: $prescriptionVM.prescription.clinicalSummary).frame(width: UIScreen.main.bounds.width-60, height: 100)
        }

        Section(header: Text("Diagnosis")) {
            TextEditor(text: $prescriptionVM.prescription.diagnosis).frame(width: UIScreen.main.bounds.width-60, height: 100)
            
            SideBySideCheckBox(isChecked: self.$prescriptionVM.prescription.diagnosisType, title1: DiagnosisTypeK.provisional.rawValue, title2: DiagnosisTypeK.definitive.rawValue)
        }
    }

}
