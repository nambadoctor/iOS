//
//  CustomStepperBox.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/15/21.
//

import SwiftUI

struct CustomStepperBox: View {
    @Binding var number:Double
    var displayName:String
    var imageName:String
    
    var body: some View {
        HStack {
            Image(imageName)
                .foregroundColor(number == 1  ? .white : .black)
            Text(displayName)
                .foregroundColor(number == 1  ? .white : .black)
                .bold()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(number == 1 ? Color.blue : Color.gray.opacity(0.5))
        .foregroundColor(number == 1 ? Color.white : Color.black)
        .cornerRadius(10)
        .onTapGesture {
            if number != 0.0 {
                number = 0.0
            } else {
                number = 1.0
            }
        }
    }
}

//HStack {
//    HStack {
//        Button(action: {
//            if number != 0 {
//                number -= 0.5
//            }
//        }, label: {
//            Image("minus")
//                .padding(7)
//        })
//
//        Text("\(number.clean)")
//            .foregroundColor(.blue)
//            .bold()
//        Button(action: {
//            number += 0.5
//        }, label: {
//            Image("plus")
//                .padding(7)
//        })
//    }
//    .padding(.horizontal)
//    .padding(.vertical, 5)
//    .background(Color.blue.opacity(0.3))
//    .cornerRadius(10)
//    Spacer()
//}
