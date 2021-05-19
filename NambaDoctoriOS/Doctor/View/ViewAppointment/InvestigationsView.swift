//
//  InvestigationsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/5/21.
//

import SwiftUI

struct InvestigationsView: View {
    @EnvironmentObject var investigationsVM:InvestigationsViewModel

    var body: some View {
        VStack (alignment: .leading) {
            
            HStack (spacing: 3){
                Image("list.triangle")
                    .scaleEffect(0.8)
                    .foregroundColor(.gray)
                
                Text("INVESTIGATIONS")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
            }

            if !investigationsVM.investigations.isEmpty {
                ForEach(Array( investigationsVM.investigations.enumerated()), id: \.0) { i, _ in
                    if !investigationsVM.investigations[i].isEmpty {
                        HStack {
                            Text("\(self.investigationsVM.investigations[i])")
                        }
                        Divider()
                    }
                }
            } else {
                HStack {
                    Text("No Investigations")
                    Spacer()
                }
            }
        }.padding()
    }
}
