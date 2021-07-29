//
//  CustomerVitalsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/29/21.
//

import SwiftUI

struct CustomerVitalsView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel

    var body: some View {
        VStack (alignment: .leading) {
            HStack {Spacer()}
            Group {
                HStack (spacing: 3) {
                    Image("eyeglasses")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("BLOOD PRESSURE")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(serviceRequestVM.serviceRequest.customerVitals.BloodPressure)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer().frame(height: 5)
            }
            
            Group {
                HStack (spacing: 3) {
                    Image("cross.case")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("BLOOD SUGAR")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(serviceRequestVM.serviceRequest.customerVitals.BloodSugar)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer().frame(height: 5)
            }
            
            Group {
                HStack (spacing: 3) {
                    Image("cross.case")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("HEIGHT")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(serviceRequestVM.serviceRequest.customerVitals.Height)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer().frame(height: 5)
            }

            Group {
                HStack (spacing: 3) {
                    Image("cross.case")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("WEIGHT")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(serviceRequestVM.serviceRequest.customerVitals.Weight)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer().frame(height: 5)
            }
            
            Group {
                HStack (spacing: 3) {
                    Image("cross.case")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("MENSTRUAL HISTORY")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(serviceRequestVM.serviceRequest.customerVitals.MenstrualHistory)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer().frame(height: 5)
            }


            Group {
                HStack (spacing: 3) {
                    Image("cross.case")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("IS SMOKER")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(self.serviceRequestVM.serviceRequest.customerVitals.IsSmoker ? "Yes" : "No")
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer().frame(height: 5)
            }
            
            Group {
                HStack (spacing: 3) {
                    Image("cross.case")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("IS ALCOHOL CONSUMER")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(self.serviceRequestVM.serviceRequest.customerVitals.IsAlcoholConsumer ? "Yes" : "No")
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer().frame(height: 5)
            }
        }
    }
}
