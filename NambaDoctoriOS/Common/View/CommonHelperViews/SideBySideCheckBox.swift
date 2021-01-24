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
            }
            
            Spacer()
            
            HStack{
                Image(systemName: isChecked == title2 ? "checkmark.square": "square")
                Text(title2)
            }
        }.padding([.leading, .trailing])
        .onTapGesture { changeSelection() }
    }
    
    //Using on tap for whole
    private func changeSelection() {
        if isChecked == title1 {
            isChecked = title2
        } else {
            isChecked = title1
        }
        EndEditingHelper.endEditing()
    }
}
