//
//  ServiceRequestEditableView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/5/21.
//

import SwiftUI

struct ServiceRequestEditableView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel
    @EnvironmentObject var configurableEntryVM:DoctorConfigurableEntryFieldsViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            
            VStack (alignment: .leading) {
                
                HStack (spacing: 3) {
                    Image("nose")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("ALLERGIES")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }

                ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.allergy.AllergyName)
                
                Group {
                    HStack (spacing: 3) {
                        Image("heart.text.square")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("PRESENTING MEDICAL HISTORY")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }

                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.medicalHistory.MedicalHistoryName)
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

                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.medicalHistory.PastMedicalHistory)
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

                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.medicalHistory.MedicationHistory)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            
            VStack (alignment: .leading) {
                
                if configurableEntryVM.selectedEntryField.Examination {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("EXAMINATION")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    

                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.examination)
                }

                
                if configurableEntryVM.selectedEntryField.Diagnosis {
                    HStack (spacing: 3) {
                        Image("cross.case")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("DIAGNOSIS")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }

                    ExpandingTextEntryView(text: $serviceRequestVM.serviceRequest.diagnosis.name)

                    SideBySideCheckBox(isChecked: $serviceRequestVM.serviceRequest.diagnosis.type, title1: "Provisional", title2: "Definitive", delegate: nil)
                        .padding(.bottom)
                }

            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}
