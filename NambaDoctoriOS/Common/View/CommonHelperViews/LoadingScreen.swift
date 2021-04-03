//
//  LoadingScreen.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 11/02/21.
//

import SwiftUI
import ActivityIndicatorView

struct LoadingScreen: View {
    
    @Binding var showLoader:Bool
    
    var body: some View {
        if showLoader {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ActivityIndicatorView(isVisible: $showLoader, type: .flickeringDots)
                         .frame(width: 50.0, height: 50.0)
                         .foregroundColor(.blue)
                    Spacer()
                }
                Spacer()
            }.background(Color.gray.opacity(0.5))
        }
    }
}
