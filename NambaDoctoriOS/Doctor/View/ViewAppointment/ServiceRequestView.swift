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
                Text("EXAMINATION")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text(serviceRequestVM.examination)
                
                Spacer().frame(height: 5)
                
                Text("DIAGNOSIS - \(serviceRequestVM.diagnosisType)")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text(serviceRequestVM.diagnosisName)
                
                Spacer().frame(height: 5)
                
                Text("ADVICE")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text(serviceRequestVM.advice)

                Spacer().frame(height: 5)
            }

            Spacer().frame(height: 5)
        }
    }
}
