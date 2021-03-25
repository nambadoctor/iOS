//
//  InvestigationsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import SwiftUI

struct InvestigationsView: View {
    
    @ObservedObject var serviceRequestVM:ServiceRequestViewModel
    
    var body: some View {
        Section(header: Text("Investigations (swipe to delete)")) {
            
            ForEach(Array(serviceRequestVM.investigations.enumerated()), id: \.0) { i, _ in
                HStack {
                    TextField("", text: $serviceRequestVM.investigations[i])
                    
                    Button {
                        serviceRequestVM.removeInvestigationManually(index: i)
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            }.onDelete(perform: serviceRequestVM.removeInvestigationBySwiping)

            TextField("Enter Investigation", text: $serviceRequestVM.investigationTemp)
            Button {
                serviceRequestVM.appendInvestigation()
            } label: {
                HStack {
                    Spacer()
                    Text("Add Investigation").foregroundColor(Color.white)
                    Spacer()
                }.padding(12).background(Color(UIColor.green)).cornerRadius(4)
            }
        }
    }
}
