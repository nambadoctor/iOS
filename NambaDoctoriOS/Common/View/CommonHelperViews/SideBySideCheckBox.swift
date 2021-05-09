//
//  SideBySideCheckBox.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import SwiftUI

protocol SideBySideCheckBoxDelegate {
    func itemChecked(value:String)
}

struct SideBySideCheckBox: View {
    @Binding var isChecked:String
    var title1:String
    var title2:String
    
    init(isChecked: Binding<String>,
        title1:String,
         title2:String,
        delegate:SideBySideCheckBoxDelegate?) {
        self.title2 = title2
        self.title1 = title1
        self._isChecked = isChecked
        self.checkBoxDelegate = delegate
    }

    var checkBoxDelegate:SideBySideCheckBoxDelegate? = nil

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
                self.checkBoxDelegate?.itemChecked(value: title1)
            }
                        
            HStack{
                Image(systemName: isChecked == title2 ? "smallcircle.fill.circle": "circle")
                    .foregroundColor(isChecked == title2 ? .blue : .gray)
                Text(title2)
                    .font(.system(size: 14))
            }.padding(.leading)
            .onTapGesture {
                isChecked = title2
                self.checkBoxDelegate?.itemChecked(value: title2)
            }

            Spacer()
        }
    }
}
