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
    @State var image:UIImage = UIImage()
    @State var showEnlarged:Bool = false
    
    
    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .cornerRadius(10)
            .shadow(radius: 10)
            .aspectRatio(contentMode: .fit)
            .frame(width:120, height:160)
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
            .onTapGesture {
                showEnlarged = true
            }
            .sheet(isPresented: self.$showEnlarged, content: {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .pinchToZoom()
                    .onDisappear() {showEnlarged = false}
            })
    }
}
