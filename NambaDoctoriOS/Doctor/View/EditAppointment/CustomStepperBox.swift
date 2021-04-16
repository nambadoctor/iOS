//
//  CustomStepperBox.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/15/21.
//

import SwiftUI

struct CustomStepperBox: View {
    @Binding var number:Int
    var body: some View {
        HStack {
            if number != 0 {
                Button(action: {
                    number -= 1
                }, label: {
                    Image("minus")
                })
            }
            Text("\(number)")
                .foregroundColor(.blue)
                .bold()
            Button(action: {
                number += 1
            }, label: {
                Image("plus")
            })
        }
        .padding()
        .background(Color.blue.opacity(0.3))
        .cornerRadius(10)
    }
}
