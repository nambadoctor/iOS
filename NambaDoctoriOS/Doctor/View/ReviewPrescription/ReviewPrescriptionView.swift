//
//  ReviewPrescriptionView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import SwiftUI

struct ReviewPrescriptionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var prescriptionVM:PrescriptionViewModel
    @ObservedObject var submitPrescriptionVM:SubmitPrescriptionViewModel
    
    init(prescriptionVM:PrescriptionViewModel) {
        self.prescriptionVM = prescriptionVM
        self.submitPrescriptionVM = SubmitPrescriptionViewModel(prescriptionVM: prescriptionVM)
    }
    
    var body: some View {
        VStack {
            ViewPrescription(prescriptionVM: prescriptionVM)

            HStack (spacing: 15) {
                Button (action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Edit").padding()
                }
                .font(.system(size: 25))
                .foregroundColor(.white)
                .background(Color(UIColor.blue))
                .cornerRadius(10)

                Button (action: {
                    submitPrescriptionVM.submitPrescription()
                }) {
                    Text("Finish Appointment").padding()
                }
                .font(.system(size: 25))
                .foregroundColor(.white)
                .background(Color(UIColor.green))
                .cornerRadius(10)
            }

            //FIND BETTER WAY TO DISMISS VIEWS WHEN WRITING PRESCRIPTION IS DONE!
            if prescriptionVM.dismissAllViews {
                Text("").onAppear() {self.presentationMode.wrappedValue.dismiss()}
            }

        }
    }
}
