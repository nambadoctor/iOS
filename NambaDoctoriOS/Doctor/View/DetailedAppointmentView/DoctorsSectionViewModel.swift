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
            investigations
        }
    }
    
    var clinicalSummary : some View {
        VStack (alignment: .leading) {
            Text("EXAMINATION:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()

            ExpandingTextView(text: self.$serviceRequestVM.serviceRequest.examination)
            Divider().padding(.bottom)

            Text("DIAGNOSIS:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            ExpandingTextView(text: $serviceRequestVM.serviceRequest.diagnosis.name)
            Divider().padding(.bottom)

            Text("ADVICE FOR PATIENT:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            ExpandingTextView(text: $serviceRequestVM.serviceRequest.advice)
            Divider()
        }.padding(.bottom)
    }
    
    var investigations : some View {
        VStack (alignment: .leading) {
            Text("INVESTIGATIONS:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            HStack (alignment: .top) {
                VStack {
                    ExpandingTextView(text: $serviceRequestVM.investigationTemp)
                    Divider()
                    
                    ForEach(self.serviceRequestVM.investigations, id: \.self) { inv in
                        HStack {
                            Text(inv)
                                .font(.callout)
                                .foregroundColor(Color.green)
                                .padding()
                            Spacer()
                        }
                        .background(Color.green.opacity(0.3))
                        .cornerRadius(7)
                    }
                }.padding(.trailing)

                Button(action: {
                    self.serviceRequestVM.appendInvestigation()
                }, label: {
                    Image("plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                })
            }
        }.padding(.bottom)
    }
}
