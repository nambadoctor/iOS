//
//  AdviceEditableView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/17/21.
//

import SwiftUI

struct AdviceEditableView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel

    var body: some View {
        VStack (alignment: .leading) {
            Text("ADVICE FOR PATIENT")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            ExpandingTextView(text: $serviceRequestVM.serviceRequest.advice)
        }
    }
}
