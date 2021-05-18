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
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(Color.blue)
                        .cornerRadius(5)
                        .padding(.vertical, 4)
                    
                    Text("ALLERGIES")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }

                ExpandingTextView(text: self.$serviceRequestVM.serviceRequest.allergy.AllergyName)
                
                HStack (spacing: 3) {
                    Image("heart.text.square")
                        .scaleEffect(0.8)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(Color.blue)
                        .cornerRadius(5)
                        .padding(.vertical, 4)
                    
                    Text("MEDICAL HISTORY")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }


                ExpandingTextView(text: self.$serviceRequestVM.serviceRequest.medicalHistory.MedicalHistoryName)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            
            VStack (alignment: .leading) {
                
                HStack (spacing: 3) {
                    Image("eyeglasses")
                        .scaleEffect(0.8)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(Color.blue)
                        .cornerRadius(5)
                        .padding(.vertical, 4)
                    
                    Text("EXAMINATION")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                

                ExpandingTextView(text: self.$serviceRequestVM.serviceRequest.examination)
                
                
                HStack (spacing: 3) {
                    Image("cross.case")
                        .scaleEffect(0.8)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(Color.blue)
                        .cornerRadius(5)
                        .padding(.vertical, 4)
                    
                    Text("DIAGNOSIS")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                ExpandingTextView(text: $serviceRequestVM.serviceRequest.diagnosis.name)

                SideBySideCheckBox(isChecked: $serviceRequestVM.serviceRequest.diagnosis.type, title1: "Provisional", title2: "Definitive", delegate: nil)
                    .padding(.bottom)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}
