//
//  CustomStepperBox.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/15/21.
//

import SwiftUI

struct CustomStepperBox: View {
    @Binding var number:Double
    var body: some View {
        HStack {
            HStack {
                Button(action: {
                    if number != 0 {
                        number -= 0.5
                    }
                }, label: {
                    Image("minus")
                        .padding(7)
                })
                
                Text("\(number.clean)")
                    .foregroundColor(.blue)
                    .bold()
                Button(action: {
                    number += 0.5
                }, label: {
                    Image("plus")
                        .padding(7)
                })
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(10)
            Spacer()
        }
    }
}
