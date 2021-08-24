//
//  CustomerVitalsEditableView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/27/21.
//

import SwiftUI

struct CustomerVitalsEditableView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel
    @EnvironmentObject var configurableEntryVM:DoctorConfigurableEntryFieldsViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            if configurableEntryVM.entryFields.BloodPressure {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("BLOOD PRESSURE")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.customerVitals.BloodPressure)
                }
            }

            if configurableEntryVM.entryFields.BloodSugar {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("BLOOD SUGAR")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.customerVitals.BloodSugar)
                }
            }
            
            if configurableEntryVM.entryFields.Height {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("HEIGHT")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.customerVitals.Height, keyboardType: .numberPad)
                }
            }
            
            if configurableEntryVM.entryFields.Weight {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("WEIGHT")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.customerVitals.Weight, keyboardType: .numberPad)
                }
            }
            
            if configurableEntryVM.entryFields.MenstrualHistory {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("MENSTRUAL HISTORY")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.customerVitals.MenstrualHistory)
                }
            }
            
            if configurableEntryVM.entryFields.ObstetricHistory {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("OBSTETRIC HISTORY")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.customerVitals.ObstetricHistory)
                }
            }
            
            if configurableEntryVM.entryFields.IsSmokerOrAlcoholic {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("IS SMOKER?")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    SideBySideCheckBox(isChecked: $serviceRequestVM.isSmoker, title1: "Yes", title2: "No", delegate: nil)
                        .padding(.bottom)
                }
                
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())
                        
                        Text("IS ALCOHOL CONSUMER?")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    SideBySideCheckBox(isChecked: $serviceRequestVM.isAlcoholConsumer, title1: "Yes", title2: "No", delegate: nil)
                        .padding(.bottom)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
