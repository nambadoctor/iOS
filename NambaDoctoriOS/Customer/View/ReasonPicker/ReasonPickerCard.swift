//
//  ReasonPickerCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/6/21.
//

import SwiftUI

struct ReasonPickerCard: View {
    
    var reason:String
    var imageName:String
    @EnvironmentObject var reasonPickerVM:ReasonPickerViewModel

    var body: some View {
        VStack {
            Text(reason)
                .fixedSize(horizontal: false, vertical: true)
                .font(.system(size: 12))
                .foregroundColor(reasonPickerVM.reason == self.reason ? Color.blue : Color.black)
            
            if imageName != "not supported" {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(reasonPickerVM.reason == self.reason ? Color.blue : Color.black)
            }
        }
        .onTapGesture {
            self.reasonPickerVM.reason = reason
            self.reasonPickerVM.reasonSelected()
        }
        .padding(8)
        .frame(width: 70, height: 75)
        .background(reasonPickerVM.reason == self.reason ? Color.blue.opacity(0.2) : Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 2)
    }
}
