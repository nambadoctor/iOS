//
//  DoctorsSectionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/03/21.
//

import SwiftUI

struct DoctorsSectionViewModel: View {
    
    @ObservedObject var serviceRequestVM:ServiceRequestViewModel
    
    var body: some View {
        VStack {
            clinicalSummary
                .padding()
                .background(Color.white)
            
            InvestigationsEntryView(investigationsViewModel: serviceRequestVM.investigationsViewModel)
                .padding()
                .background(Color.white)
        }
    }
    
    var clinicalSummary : some View {
        VStack (alignment: .leading) {
//            Text("Doctor's Section")
//                .font(.title)
//                .bold()
//                .padding([.top, .bottom])

            Text("EXAMINATION:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()

            ExpandingTextView(text: self.$serviceRequestVM.serviceRequest.examination)

            Text("DIAGNOSIS:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            ExpandingTextView(text: $serviceRequestVM.serviceRequest.diagnosis.name)
            
            SideBySideCheckBox(isChecked: $serviceRequestVM.serviceRequest.diagnosis.type, title1: "Provisional", title2: "Definitive")
                .padding(.bottom)

            Text("ADVICE FOR PATIENT:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            ExpandingTextView(text: $serviceRequestVM.serviceRequest.advice)
        }.padding(.bottom)
    }
}
