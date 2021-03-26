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
                Image(systemName: isChecked == title1 ? "checkmark.square": "square")
                Text(title1)
                    .font(.system(size: 14))
            }.padding(.trailing)
                        
            HStack{
                Image(systemName: isChecked == title2 ? "checkmark.square": "square")
                Text(title2)
                    .font(.system(size: 14))
            }.padding(.leading)

            Spacer()
        }
        .onTapGesture {
            changeSelection()
        }
    }
    
    //Using on tap for whole
    private func changeSelection() {
        if isChecked == title1 {
            isChecked = title2
            print("checking if")
        } else {
            isChecked = title1
            print("checking else")
        }
        EndEditingHelper.endEditing()
    }
}
