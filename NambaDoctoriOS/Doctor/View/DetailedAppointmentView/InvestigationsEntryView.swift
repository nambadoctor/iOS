//
//  InvestigationsEntryView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/03/21.
//

import SwiftUI

struct InvestigationsEntryView: View {
    @ObservedObject var investigationsViewModel:InvestigationsViewModel
    var body: some View {
        investigations
    }
    
    var investigations : some View {
        VStack (alignment: .leading) {
            Text("INVESTIGATIONS:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            HStack (alignment: .top) {
                VStack {
                    ExpandingTextView(text: $investigationsViewModel.investigationTemp)
                    Divider()
                    
                    ForEach(self.investigationsViewModel.investigations, id: \.self) { inv in
                        HStack {
                            Text(inv)
                                .font(.callout)
                                .foregroundColor(Color.blue)
                                .padding()
                            Spacer()
                            
                            Button {
                                investigationsViewModel.removeInvestigationManually(investigation: inv)
                            } label: {
                                Image("xmark.circle")
                                    .foregroundColor(Color.blue)
                                    .padding(.trailing)
                            }
                        }
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(7)
                        .padding(.top, 1)
                    }
                }.padding(.trailing)

                Button(action: {
                    self.investigationsViewModel.appendInvestigation()
                }, label: {
                    Image("plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                })
            }
        }.padding(.bottom)
    }
}
