//
//  PinchToZoom.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 26/11/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import UIKit
import SwiftUI

struct PinchToZoom: ViewModifier {
    @State private var zoomLevel:CGFloat = 1
    func body(content: Content) -> some View {
        content
            .scaleEffect(zoomLevel)
            .gesture(MagnificationGesture().onChanged({ value in
                self.zoomLevel = value
            }))
    }
}

extension View {
    func pinchToZoom() -> some View {
        self.modifier(PinchToZoom())
    }
}

struct DraggableView: ViewModifier {
    @State var offset = CGPoint(x: 0, y: 0)
    
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    self.offset.x += value.location.x - value.startLocation.x
                    self.offset.y += value.location.y - value.startLocation.y
            })
            .offset(x: offset.x, y: offset.y)
    }
}

extension View {
    func draggable() -> some View {
        return modifier(DraggableView())
    }
}
