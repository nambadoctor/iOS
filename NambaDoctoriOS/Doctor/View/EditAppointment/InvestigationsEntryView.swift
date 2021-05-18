//
//  InvestigationsEntryView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/03/21.
//

import SwiftUI

struct InvestigationsEditableView: View {
    @EnvironmentObject var investigationsVM:InvestigationsViewModel
    
    var body : some View {
        VStack (alignment: .leading) {
            
            HStack (spacing: 3){
                Image("list.triangle")
                    .scaleEffect(0.8)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(Color.blue)
                    .cornerRadius(5)
                    .padding(.vertical, 4)
                
                Text("INVESTIGATIONS")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }

            HStack (alignment: .top) {
                VStack {
                    ExpandingTextView(text: $investigationsVM.investigationTemp)
                    
                    ForEach(self.investigationsVM.investigations, id: \.self) { inv in
                        HStack {
                            Text(inv)
                                .font(.callout)
                                .foregroundColor(Color.blue)
                                .padding()
                            Spacer()
                            
                            Button {
                                investigationsVM.removeInvestigationManually(investigation: inv)
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
                    self.investigationsVM.appendInvestigation()
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
