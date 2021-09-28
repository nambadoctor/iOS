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
        VStack (alignment: .leading, spacing: 10) {
            HStack (spacing: 3) {
                
                Image("indianrupeesign.circle")
                    .modifier(DetailedAppointmentViewIconModifier())

                Text("FEE")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Spacer()
            }

            HStack {
                TextField("\(modifyFeeVM.fee)", text: $modifyFeeVM.fee)
                    .keyboardType(.numberPad)
                    .frame(width: 80, height: 5)
                    .padding()
                    .background(Color.gray.opacity(0.09))
                    .cornerRadius(10)
                    .padding(.trailing)
                
                LargeButton(title: "Click to waive fee") {
                    self.modifyFeeVM.waiveFee()
                }
            }
        }
    }
}
