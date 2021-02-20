//
//  LoadingScreen.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 11/02/21.
//

import SwiftUI

struct LoadingScreen: View {
    
    @Binding var showLoader:Bool
    
    var body: some View {
        if showLoader {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ProgressView("Loading...")
                        .scaleEffect(1.5, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .foregroundColor(.blue)
                    Spacer()
                }
                Spacer()
            }.background(Color.gray.opacity(0.5))
        }
    }
}
