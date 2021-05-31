//
//  LoadingScreen.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 11/02/21.
//

import SwiftUI
import ActivityIndicatorView

var loadingText:String = "Loading..."

struct LoadingScreen: View {
    
    @State private var moveRightLeft = false
    let screenFrame = Color(.systemBackground)
    @Binding var showLoader:Bool
    @Binding var completed:Bool
    
    var body: some View {
        if showLoader {
            ZStack {
                screenFrame.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    if completed {
                        CheckBoxAnimation()
                    } else {
                        ZStack {
                            Capsule()
                                .frame(width: 128, height: 6, alignment: .center)
                                .foregroundColor(Color(.systemGray4))
                            
                            Capsule()
                                .clipShape(Rectangle().offset(x: moveRightLeft ? 80 : -80))
                                .frame(width: 100, height: 6, alignment: .leading)
                                .foregroundColor(Color(.systemBlue))
                                .offset(x: moveRightLeft ? 14 : -14)
                                .animation(Animation.easeInOut(duration: 0.5).delay(0.2).repeatForever(autoreverses: true))
                                .onAppear() {
                                    moveRightLeft.toggle()
                                }
                        }
                    }
                    
                    Text(loadingText)
                }
            }
        }
    }
}

struct CheckBoxAnimation : View {
    
    @State var rotateBlueCircle = false
    @State var scaleUpGreenCircle = false
    @State var drawCheckMark = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 1/20, to: 1)
                .stroke(Color.blue, lineWidth: 4)
                .frame(width: 124, height: 124)
                .rotationEffect(.degrees(rotateBlueCircle ? 0 : -1440), anchor: .center)
                .animation(Animation.easeIn(duration: 0.7))
                .onAppear() {self.rotateBlueCircle.toggle()}
            
            Circle()
                .frame(width: 128, height: 128)
                .foregroundColor(.green)
                .scaleEffect(scaleUpGreenCircle ? 1 : 0, anchor: .center)
                .animation(Animation.easeOut(duration: 0.7))
                .onAppear() {self.scaleUpGreenCircle.toggle()}
            
            Path { path in
                path.addLines([
                    .init(x: 70, y: 100),
                    .init(x: 80, y: 110),
                    .init(x: 100, y: 90)
                ])
            }.trim(from: 0, to: drawCheckMark ? 1 : 0)
            .scale(2, anchor: .topLeading)
            .stroke(Color.white, lineWidth: 10)
            .animation(Animation.easeOut(duration: 0.0).delay(0.7))
            .offset(x: 35, y: 190)
            .onAppear() { self.drawCheckMark.toggle() }
        }
    }
}
