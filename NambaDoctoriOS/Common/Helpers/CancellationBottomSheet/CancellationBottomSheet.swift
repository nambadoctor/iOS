//
//  CancellationBottomSheet.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/19/21.
//

import SwiftUI
import Foundation

protocol CancellationDelegate {
    func cancel(reasonName:String)
}

struct CancellationBottomSheet : View {
    
    @Binding var bottomSheetOffset : CGFloat
    var cancellationReasons:[String]
    var delegate:CancellationDelegate
    
    var disclaimerText:String
    
    @State private var checkedOption:String = ""
    @State private var customReason:String = ""
    
    var body : some View {
        
        VStack(alignment: .leading, spacing: 15){
            
            HStack {
                Image("reportAbuse").foregroundColor(Color(UIColor.Red))
                
                Text("Cancel Appointment") .font(Font.system(size:15).weight(.bold))
                    .foregroundColor(Color.black)
                
                Spacer()
            }
            
            if !disclaimerText.isEmpty {
                Text("*\(disclaimerText)*")
                    .foregroundColor(.red)
                    .textCase(.uppercase)
            }
            
            Text("Please select one of the below before cancelling")
                .font(Font.system(size:14))
                .foregroundColor(Color(UIColor.lightGray))
            
            VStack {
                ForEach(self.cancellationReasons, id: \.self) {reason in
                    CheckboxField(
                        label: reason,
                        size: 14,
                        textSize: 14,
                        callback: checkboxSelected,
                        checkedOption: self.$checkedOption
                    )
                    
                    if self.checkedOption == "Other" && reason == "Other" {
                        ExpandingTextEntryView(text: self.$customReason)
                            .keyboardAdaptive(specificOffSet: 0)
                    }
                }
            }

            HStack {
                Spacer()
                Button ("Back") {
                    LoggerService().log(eventName: "Closed cancellation sheet (did not cancel appointment)")
                    self.bottomSheetOffset = UIScreen.main.bounds.height
                } .font(Font.system(size:13)).foregroundColor(Color(UIColor.gray)).padding(.trailing, 10)
                
                Button ("Confirm") {
                    if self.checkedOption == "Other" {
                        LoggerService().log(eventName: "Custom cancel option \(self.customReason)")
                        self.delegate.cancel(reasonName: "Other: \(self.customReason)")
                    } else {
                        LoggerService().log(eventName: "Preset cancel option selected \(self.checkedOption)")
                        self.delegate.cancel(reasonName: self.checkedOption)
                    }
                }.frame(width: 90, height: 33)
                .background(Color(UIColor.red))
                .font(Font.system(size:13))
                .foregroundColor(.white)
                .font(Font.system(size:13))
                .cornerRadius(4)
            }
            
            
        }
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .padding(.horizontal)
        .padding(.top,20)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(25)
        
    }
    
    func checkboxSelected(id: String) {
        self.checkedOption = id
    }
}
