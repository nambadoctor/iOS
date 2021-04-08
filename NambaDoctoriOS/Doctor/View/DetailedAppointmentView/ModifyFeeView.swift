//
//  WaiveFeeView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/1/21.
//

import SwiftUI

struct ModifyFeeView: View {
    
    @ObservedObject var modifyFeeVM:ModifyFeeViewModel
    
    var body : some View {
        VStack (alignment: .leading) {
            HStack{Spacer()}
            
            Text("Fee (₹)")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            
            HStack {
                TextField("\(modifyFeeVM.fee)", text: $modifyFeeVM.fee)
                    .keyboardType(.numberPad)
                    .frame(width: 80, height: 15)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.trailing)
            }
        }
    }
}
