//
//  ServiceRequestEditableView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/5/21.
//

import SwiftUI

struct ServiceRequestEditableView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            
            VStack (alignment: .leading) {
                Text("Patient Allergies:")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()

                ExpandingTextView(text: self.$serviceRequestVM.serviceRequest.allergy.AllergyName)
                
                Text("Patient Medical History:")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()

                ExpandingTextView(text: self.$serviceRequestVM.serviceRequest.medicalHistory.MedicalHistoryName)
            }
            .padding()
            .background(Color.white)
            
            VStack (alignment: .leading) {
                Text("EXAMINATION:")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()

                ExpandingTextView(text: self.$serviceRequestVM.serviceRequest.examination)

                Text("DIAGNOSIS:")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                ExpandingTextView(text: $serviceRequestVM.serviceRequest.diagnosis.name)

                SideBySideCheckBox(isChecked: $serviceRequestVM.serviceRequest.diagnosis.type, title1: "Provisional", title2: "Definitive")
                    .padding(.bottom)

                Text("ADVICE FOR PATIENT:")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                ExpandingTextView(text: $serviceRequestVM.serviceRequest.advice)

            }
            .padding()
            .background(Color.white)
            
        }.padding(.bottom)
    }
}
