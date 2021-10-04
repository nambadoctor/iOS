//
//  ImageViewHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/27/21.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var showEnlarged:Bool = false

    var height:CGFloat = 160
    var width:CGFloat = 120
    
    var body: some View {
        if imageLoader.url != nil {
            WebImage(url: imageLoader.url!)
                .resizable()
                .indicator(.activity) // Activity Indicator
                .aspectRatio(contentMode: .fit)
                .frame(width: self.width, height: self.height, alignment: .center)
                .onTapGesture {
                    showEnlarged = true
                } 
                .sheet(isPresented: self.$showEnlarged, content: {
                    VStack (alignment: .center) {
                        HStack {
                            Spacer()
                            Button {
                                self.showEnlarged = false
                            } label: {
                                Image("xmark.circle")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(.blue)
                            }.padding()
                        }

                        WebImage(url: imageLoader.url!)
                            .resizable()
                            .indicator(.activity) // Activity Indicator
                            .aspectRatio(contentMode: .fit)
                            .draggable()
                            .pinchToZoom()
                            .onDisappear() {showEnlarged = false}
                    }
                })
        }
    }
}

struct ImageViewWithNoSheet: View {
    var url:String
    
    var height:CGFloat = 160
    var width:CGFloat = 120
    
    var body: some View {
        WebImage(url: URL(string: url))
            .resizable()
            .placeholder(Image(systemName: "person.crop.circle.fill")) // Placeholder Image
            // Supports ViewBuilder as well
            .placeholder {
                Image("person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.gray)
            }
            .indicator(.activity) // Activity Indicator
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height, alignment: .center)
    }
}

struct ImageViewWithData: View {
    var data:Data
    
    var height:CGFloat = 160
    var width:CGFloat = 120
    
    var body: some View {
        Image(uiImage: UIImage(data: data)!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height, alignment: .center)
    }
}

