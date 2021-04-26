//
//  SideBySideCheckBox.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import SwiftUI

struct SideBySideCheckBox: View {
    @Binding var isChecked:String
    var title1:String
    var title2:String

    var body: some View {
        HStack {
            HStack{
                Image(systemName: isChecked == title1 ? "smallcircle.fill.circle": "circle")
                    .foregroundColor(isChecked == title1 ? .blue : .gray)
                Text(title1)
                    .font(.system(size: 14))
            }.padding(.trailing)
            .onTapGesture {
                isChecked = title1
            }
                        
            HStack{
                Image(systemName: isChecked == title2 ? "smallcircle.fill.circle": "circle")
                    .foregroundColor(isChecked == title2 ? .blue : .gray)
                Text(title2)
                    .font(.system(size: 14))
            }.padding(.leading)
            .onTapGesture {
                isChecked = title2
            }

            Spacer()
        }
    }
}
