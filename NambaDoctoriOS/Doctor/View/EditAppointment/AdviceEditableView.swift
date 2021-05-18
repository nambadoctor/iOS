//
//  AdviceEditableView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/17/21.
//

import SwiftUI

struct AdviceEditableView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel

    var body: some View {
        VStack (alignment: .leading) {
            
            HStack (spacing: 3) {
                Image("cross.circle")
                    .scaleEffect(0.8)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(Color.blue)
                    .cornerRadius(5)
                    .padding(.vertical, 4)
                
                Text("ADVICE")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }
            
            ExpandingTextView(text: $serviceRequestVM.serviceRequest.advice)
        }
    }
}
