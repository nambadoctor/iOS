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
        VStack {
            Group {
                Text("Examination")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text(serviceRequestVM.examination)
                
                Spacer().frame(height: 5)
                
                Text("Diagnosis - \(serviceRequestVM.diagnosisType)")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text(serviceRequestVM.diagnosisName)
                
                Spacer().frame(height: 5)
                
                Text("Examination")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text(serviceRequestVM.advice)
                
                Spacer().frame(height: 5)
            }
            
            Text("Investigations")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)

            Spacer().frame(height: 5)
        }
    }
}
