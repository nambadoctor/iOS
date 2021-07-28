//
//  CustomerVitalsEditableView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/27/21.
//

import SwiftUI

struct CustomerVitalsEditableView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
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
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
