//
//  KeyboardResponder.swift
//  CircleAppiOS
//
//  Created by Surya Manivannan on 26/07/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI
import Combine

/// Note that the `KeyboardAdaptive` modifier wraps your view in a `GeometryReader`,
/// which attempts to fill all the available space, potentially increasing content view size.
struct KeyboardAdaptive: ViewModifier {
    @State private var bottomPadding: CGFloat = 0
    var specificOffSet:CGFloat = 0
    
    init(specificOffSet:CGFloat) {
        self.specificOffSet = specificOffSet
    }

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.bottomPadding)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
                    let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                    self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom - self.specificOffSet)
            }
            .animation(.easeOut(duration: 0.16))
        }
    }
}

extension View {
    func keyboardAdaptive(specificOffSet:CGFloat) -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive(specificOffSet: specificOffSet))
    }
}
