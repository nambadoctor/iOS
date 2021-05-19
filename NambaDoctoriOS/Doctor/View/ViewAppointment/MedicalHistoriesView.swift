//
//  PatientInfoView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/19/21.
//

import SwiftUI

struct MedicalHistoriesView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            HStack{Spacer()}
            HStack (spacing: 3) {
                Image("nose")
                    .scaleEffect(0.8)
                    .foregroundColor(.gray)
                
                Text("ALLERGIES")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }
            Text(self.serviceRequestVM.serviceRequest.allergy.AllergyName.isEmpty ? "No allergies entered" : self.serviceRequestVM.serviceRequest.allergy.AllergyName)
                .fixedSize(horizontal: false, vertical: true)
            
            Group {
                HStack (spacing: 3) {
                    Image("heart.text.square")
                        .scaleEffect(0.8)
                        .foregroundColor(.gray)
                    
                    Text("PRESENTING MEDICAL HISTORY")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(self.serviceRequestVM.serviceRequest.medicalHistory.MedicalHistoryName)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Group {
                HStack (spacing: 3) {
                    Image("heart.text.square")
                        .scaleEffect(0.8)
                        .foregroundColor(.gray)
                    
                    Text("PAST MEDICAL HISTORY")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(self.serviceRequestVM.serviceRequest.medicalHistory.PastMedicalHistory)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Group {
                HStack (spacing: 3) {
                    Image("heart.text.square")
                        .scaleEffect(0.8)
                        .foregroundColor(.gray)
                    
                    Text("MEDICATION HISTORY")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(self.serviceRequestVM.serviceRequest.medicalHistory.MedicationHistory)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal)
    }
}
