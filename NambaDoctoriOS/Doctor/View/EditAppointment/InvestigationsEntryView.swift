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
                    .modifier(DetailedAppointmentViewIconModifier())
                
                Text("INVESTIGATIONS")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }

            HStack (alignment: .top) {
                VStack {
                    ExpandingTextEntryView(text: $investigationsVM.investigationTemp)
                    
                    ForEach(self.investigationsVM.investigations, id: \.self) { inv in
                        HStack {
                            Text(inv)
                                .font(.callout)
                                .foregroundColor(Color.blue)
                                .padding()
                                .fixedSize(horizontal: false, vertical: true)
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
