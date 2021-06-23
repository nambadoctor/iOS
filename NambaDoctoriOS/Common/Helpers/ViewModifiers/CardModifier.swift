//
//  CardModifier.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/27/21.
//

import SwiftUI

struct CardModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.horizontal)
    }
}

struct CardModifierControlledPadding : ViewModifier {
    var horizontalPadding:CGFloat
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.horizontal, horizontalPadding)
    }
}

struct SmallCardModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical)
            .padding(.horizontal, 10)
            .frame(height: 110)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
    }
}
