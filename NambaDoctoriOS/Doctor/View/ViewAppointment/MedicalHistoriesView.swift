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
                    .modifier(DetailedAppointmentViewIconModifier())
                
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
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("PRESENTING MEDICAL HISTORY")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(self.serviceRequestVM.serviceRequest.medicalHistory.MedicalHistoryName.isEmpty ? "No Presenting Medical History Entered" : self.serviceRequestVM.serviceRequest.medicalHistory.MedicalHistoryName)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Group {
                HStack (spacing: 3) {
                    Image("heart.text.square")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("PAST MEDICAL HISTORY")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(self.serviceRequestVM.serviceRequest.medicalHistory.PastMedicalHistory.isEmpty ? "No Past Medical History Entered" : self.serviceRequestVM.serviceRequest.medicalHistory.PastMedicalHistory)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Group {
                HStack (spacing: 3) {
                    Image("heart.text.square")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("MEDICATION HISTORY")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(self.serviceRequestVM.serviceRequest.medicalHistory.MedicationHistory.isEmpty ? "No Medication History Entered" : self.serviceRequestVM.serviceRequest.medicalHistory.MedicationHistory)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
