//
//  ServiceRequestView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/5/21.
//

import SwiftUI

struct ServiceRequestView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {Spacer()}
            Group {
                
                HStack (spacing: 3) {
                    Image("eyeglasses")
                        .scaleEffect(0.8)
                        .foregroundColor(.gray)
                    Text("EXAMINATION")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(serviceRequestVM.examination)
                
                Spacer().frame(height: 5)
                
                
                HStack (spacing: 3) {
                    Image("cross.case")
                        .scaleEffect(0.8)
                        .foregroundColor(.gray)
                    Text("DIAGNOSIS - \(serviceRequestVM.diagnosisType)")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(serviceRequestVM.diagnosisName)
                
                Spacer().frame(height: 5)
                
                HStack (spacing: 3) {
                    Image("cross.circle")
                        .foregroundColor(.gray)
                        .scaleEffect(0.8)
                    
                    Text("ADVICE")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Text(serviceRequestVM.advice)

                Spacer().frame(height: 5)
            }

            Spacer().frame(height: 5)
        }
        .padding()
    }
}
