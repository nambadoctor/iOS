//
//  Indicator.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import SwiftUI
import ActivityIndicatorView

struct Indicator: View {
    @State var loadState:Bool = true
    var body: some View {
        ActivityIndicatorView(isVisible: $loadState, type: .flickeringDots)
             .frame(width: 50.0, height: 50.0)
             .foregroundColor(.blue)
    }
}
