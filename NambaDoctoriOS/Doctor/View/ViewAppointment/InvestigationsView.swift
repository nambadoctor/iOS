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
        VStack {
            if !investigationsVM.investigations.isEmpty {
                ForEach(Array( investigationsVM.investigations.enumerated()), id: \.0) { i, _ in
                    if !investigationsVM.investigations[i].isEmpty {
                        HStack {
                            Text("\(self.investigationsVM.investigations[i])")
                            Divider()
                        }
                    }
                }
            } else {
                Text("No Investigations")
            }
        }
    }
}
