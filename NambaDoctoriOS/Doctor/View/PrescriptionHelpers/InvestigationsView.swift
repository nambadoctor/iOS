//
//  InvestigationsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import SwiftUI

struct InvestigationsView: View {
    
    @ObservedObject var investigationsVM:InvestigationsViewModel
    
    var body: some View {
        Section(header: Text("Investigations (swipe to delete)")) {
            
            ForEach(Array(investigationsVM.investigations.enumerated()), id: \.0) { i, _ in
                HStack {
                    Text("\(investigationsVM.investigations[i])")
                }
            }.onDelete(perform: investigationsVM.removeInvestigationRows)

            TextField("Enter Investigation", text: $investigationsVM.investigationTemp)
            Button {
                investigationsVM.appendInvestigation()
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
