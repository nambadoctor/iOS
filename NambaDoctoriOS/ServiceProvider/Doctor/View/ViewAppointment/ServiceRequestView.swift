//
//  ServiceRequestView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/5/21.
//

import SwiftUI

struct AdviceView : View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {Spacer()}
            HStack (spacing: 3) {
                Image("cross.circle")
                    .modifier(DetailedAppointmentViewIconModifier())
                
                Text("ADVICE")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }
            
            Text(serviceRequestVM.advice)
                .fixedSize(horizontal: false, vertical: true)

            Spacer().frame(height: 5)
        }
    }
}

struct ServiceRequestView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            HStack {Spacer()}
            Group {
                
                HStack (spacing: 3) {
                    Image("eyeglasses")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("EXAMINATION")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(serviceRequestVM.examination)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer().frame(height: 5)
                
                
                HStack (spacing: 3) {
                    Image("cross.case")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("DIAGNOSIS - \(serviceRequestVM.diagnosisType)")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(serviceRequestVM.diagnosisName)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer().frame(height: 5)
            }

            Spacer().frame(height: 5)
        }
    }
}
