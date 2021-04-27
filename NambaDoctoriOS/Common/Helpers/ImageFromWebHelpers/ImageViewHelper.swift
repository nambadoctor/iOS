//
//  ImageViewHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/27/21.
//

import Foundation
import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var showEnlarged:Bool = false
    
    var height:CGFloat = 160
    var width:CGFloat = 120
    
    var body: some View {
        if imageLoader.image != nil {
            Image(uiImage: imageLoader.image!)
                .resizable()
                .cornerRadius(10)
                .shadow(radius: 10)
                .aspectRatio(contentMode: .fit)
                .frame(width:self.width, height:self.height)
                .onTapGesture {
                    showEnlarged = true
                }
                .sheet(isPresented: self.$showEnlarged, content: {
                    ZStack (alignment: .center) {
                        VStack{
                            HStack {
                                Spacer()
                                Button {
                                    self.showEnlarged.toggle()
                                } label: {
                                    Image("xmark.circle")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(.blue)
                                }.padding()
                            }
                            Spacer()
                        }

                        Image(uiImage: imageLoader.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .pinchToZoom()
                            .onDisappear() {showEnlarged = false}
                    }
                })
        }
    }
}
