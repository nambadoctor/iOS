//
//  PopupView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/15/21.
//

import SwiftUI

struct Popup: ViewModifier {
    let alignment: Alignment
    let direction: Direction
    @Binding var isPresented: Bool

    init(isPresented: Binding<Bool>, alignment: Alignment, direction: Direction) {
        self._isPresented = isPresented
        self.alignment = alignment
        self.direction = direction
    }

    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                Snackbar()
                    .animation(.spring())
                    .transition(.offset(x: 0, y: direction.offset(popupFrame: geometry.frame(in: .global))))
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
                    .onTapGesture {
                        self.isPresented = false
                    }
            }
        }
    }
}

extension Popup {
    enum Direction {
        case top, bottom

        func offset(popupFrame: CGRect) -> CGFloat {
            switch self {
            case .top:
                let aboveScreenEdge = -popupFrame.maxY
                return aboveScreenEdge
            case .bottom:
                let belowScreenEdge = UIScreen.main.bounds.height - popupFrame.minY
                return belowScreenEdge
            }
        }
    }
}
