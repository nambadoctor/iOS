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
            
            Toggle("Change Fee For This Appointment", isOn: $modifyFeeVM.toggleModify)
                .padding(.bottom, 5)
            
            if modifyFeeVM.toggleModify {
                HStack {
                    TextField("₹\(modifyFeeVM.fee)", text: $modifyFeeVM.fee)
                        .keyboardType(.numberPad)
                        .frame(width: 80, height: 20)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.trailing)
                    
                    LargeButton(title: "Modify Fee") {
                        self.modifyFeeVM.modifyFee()
                    }
                }
                
                HStack {
                    Spacer()
                    Text("OR")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    Spacer()
                }
                
                LargeButton(title: "Waive Fee", disabled: false, backgroundColor: Color.white, foregroundColor: Color.green) {
                    self.modifyFeeVM.waiveFee()
                }
            }
        }
    }
}
