//
//  BubbledSelector.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 26/03/21.
//

import SwiftUI

struct BubbledSelector: View {
    var title:String
    var array:[String]
    @Binding var selected:String
    @State var limitToFour:Bool
    
    var body: some View {
        VStack {
            
            HStack {
                if !title.isEmpty {
                    Text("\(title):")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                }
                
                Spacer()
                
                if array.count > 4 {
                    Button (action: {
                        self.limitToFour.toggle()
                    }, label: {
                        Text(limitToFour ? "show more" : "show less")
                            .font(.footnote)
                    })
                }
            }
            
            if array.count < 4 {
                TagCloudView(tags: array, selectedTag: $selected)
            } else {
                if limitToFour {
                    TagCloudView(tags: getLimitedTo4Array(), selectedTag: $selected)
                } else {
                    TagCloudView(tags: array, selectedTag: $selected)
                }
            }
        }
    }
    
    func getLimitedTo4Array () -> [String] {
        var arr:[String] = [String]()
        for n in 0...3 {
            arr.append(array[n])
        }
        
        return arr
    }
}
