//
//  CheckboxField.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/19/21.
//

import SwiftUI

//MARK:- Checkbox Field
struct CheckboxField: View {
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: Int
    let callback: (String)->()
    @Binding var checkedOption:String

    init(
        label:String,
        size: CGFloat = 10,
        color: Color = Color.black,
        textSize: Int = 14,
        callback: @escaping (String)->(),
        checkedOption: Binding<String>
        ) {
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.callback = callback
        self._checkedOption = checkedOption
    }


    var body: some View {
        Button(action:{
            self.callback(self.label)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.checkedOption == self.label ? "checkmark.square" : "square")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: size))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}
