//
//  AdviceEditableView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/17/21.
//

import SwiftUI

struct AdviceEditableView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel
    @EnvironmentObject var configurableEntryVM:DoctorConfigurableEntryFieldsViewModel
    
    var body: some View {
        if configurableEntryVM.entryFields.Advice {
            VStack (alignment: .leading) {
                HStack (spacing: 3) {
                    Image("cross.circle")
                        .modifier(DetailedAppointmentViewIconModifier())
                    
                    Text("ADVICE")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                ExpandingTextEntryView(text: $serviceRequestVM.serviceRequest.advice)
            }
        }
    }
}
