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
                                .foregroundColor(Color.green)
                                .padding()
                            Spacer()
                        }
                        .background(Color.green.opacity(0.3))
                        .cornerRadius(7)
                    }
                }.padding(.trailing)

                Button(action: {
                    self.investigationsViewModel.appendInvestigation()
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
