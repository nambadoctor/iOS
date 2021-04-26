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
                
                HStack (spacing: 3) {
                    Image("nose")
                        .scaleEffect(0.8)
                        .foregroundColor(.gray)
                    Text("ALLERGIES")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }

                ExpandingTextView(text: self.$serviceRequestVM.serviceRequest.allergy.AllergyName)
                
                HStack (spacing: 3) {
                    Image("heart.text.square")
                        .scaleEffect(0.8)
                        .foregroundColor(.gray)
                    Text("MEDICAL HISTORY")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }


                ExpandingTextView(text: self.$serviceRequestVM.serviceRequest.medicalHistory.MedicalHistoryName)
            }
            .padding()
            .background(Color.white)
            
            VStack (alignment: .leading) {
                
                HStack (spacing: 3) {
                    Image("eyeglasses")
                        .scaleEffect(0.8)
                        .foregroundColor(.gray)
                    Text("EXAMINATION")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                

                ExpandingTextView(text: self.$serviceRequestVM.serviceRequest.examination)
                
                
                HStack (spacing: 3) {
                    Image("cross.case")
                        .scaleEffect(0.8)
                        .foregroundColor(.gray)
                    Text("DIAGNOSIS")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                ExpandingTextView(text: $serviceRequestVM.serviceRequest.diagnosis.name)

                SideBySideCheckBox(isChecked: $serviceRequestVM.serviceRequest.diagnosis.type, title1: "Provisional", title2: "Definitive")
                    .padding(.bottom)
            }
            .padding()
            .background(Color.white)
            
        }
    }
}
