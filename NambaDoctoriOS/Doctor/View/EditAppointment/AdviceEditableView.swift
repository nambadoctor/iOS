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
                    .modifier(DetailedAppointmentViewIconModifier())
                
                Text("ADVICE")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }
            
            ExpandingTextView(text: $serviceRequestVM.serviceRequest.advice)
        }
    }
}
