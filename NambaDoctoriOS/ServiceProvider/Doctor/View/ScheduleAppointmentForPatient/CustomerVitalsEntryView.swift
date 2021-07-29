//
//  CustomerVitalsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/25/21.
//

import SwiftUI

class CustomerVitalsEntryViewModel : ObservableObject {
    @Published var customerVitals:ServiceProviderCustomerVitals = ServiceProviderCustomerVitals(BloodPressure: "", BloodSugar: "", Height: "", Weight: "", MenstrualHistory: "", ObstetricHistory: "", IsSmoker: false, IsAlcoholConsumer: false)

    @Published var isSmoker:String = "No"
    @Published var isAlcoholConsumer:String = "No"

    @Published var allergies:String = ""
    @Published var medicalHistory:String = ""
    
    func confirmVitals () {
        if isSmoker == "No" {
            customerVitals.IsSmoker = false
        } else {
            customerVitals.IsSmoker = true
        }
        
        if isAlcoholConsumer == "No" {
            customerVitals.IsAlcoholConsumer = false
        } else {
            customerVitals.IsAlcoholConsumer = true
        }
    }
}

struct CustomerVitalsEntryView: View {
    
    @ObservedObject var customerVitalsVM:CustomerVitalsEntryViewModel
    
    var body: some View {
        Group {
            HStack (spacing: 3) {
                Image("eyeglasses")
                    .modifier(DetailedAppointmentViewIconModifier())
                
                Text("BLOOD PRESSURE")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }
            ExpandingTextEntryView(text: self.$customerVitalsVM.customerVitals.BloodPressure)
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
            ExpandingTextEntryView(text: self.$customerVitalsVM.customerVitals.BloodSugar)
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
            
            ExpandingTextEntryView(text: self.$customerVitalsVM.customerVitals.Height, keyboardType: .numberPad)
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
            
            ExpandingTextEntryView(text: self.$customerVitalsVM.customerVitals.Weight, keyboardType: .numberPad)
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
            ExpandingTextEntryView(text: self.$customerVitalsVM.customerVitals.MenstrualHistory)
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
            ExpandingTextEntryView(text: self.$customerVitalsVM.customerVitals.ObstetricHistory)
        }
        
        Group {
            HStack (spacing: 3) {
                Image("eyeglasses")
                    .modifier(DetailedAppointmentViewIconModifier())
                
                Text("ALLERGIES")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }
            ExpandingTextEntryView(text: self.$customerVitalsVM.allergies)
        }
        
        Group {
            HStack (spacing: 3) {
                Image("eyeglasses")
                    .modifier(DetailedAppointmentViewIconModifier())
                
                Text("MEDICAL HISTORY")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }
            ExpandingTextEntryView(text: self.$customerVitalsVM.medicalHistory)
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
            SideBySideCheckBox(isChecked: $customerVitalsVM.isSmoker, title1: "Yes", title2: "No", delegate: nil)
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
            SideBySideCheckBox(isChecked: $customerVitalsVM.isAlcoholConsumer, title1: "Yes", title2: "No", delegate: nil)
                .padding(.bottom)
        }
    }
}
