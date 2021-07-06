//
//  BookingReasonBottomSheet.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/6/21.
//

import SwiftUI

struct BookingReasonBottomSheet : View {
    
    @Binding var bottomSheetOffset : CGFloat
    var preBookingOptionsReasons:[String]
    var preBookingOptionsCallback:(String)->()
        
    @State private var checkedOption:String = ""
    @State private var customReason:String = ""
    
    var body : some View {
        
        VStack(alignment: .leading, spacing: 15){
            
            HStack {
                Image("person.2.fill").foregroundColor(Color(UIColor.Red))
                
                Text("How do you know this doctor?") .font(Font.system(size:15).weight(.bold))
                    .foregroundColor(Color.black)
                
                Spacer()
            }
            
            VStack {
                ForEach(self.preBookingOptionsReasons, id: \.self) {reason in
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
                    LoggerService().log(eventName: "Closed Booking Reason sheet")
                    self.bottomSheetOffset = UIScreen.main.bounds.height
                } .font(Font.system(size:13)).foregroundColor(Color(UIColor.gray)).padding(.trailing, 10)
                
                Button ("Confirm") {
                    if self.checkedOption == "Other" {
                        LoggerService().log(eventName: "Custom Booking Reason Selected \(self.customReason)")
                        self.preBookingOptionsCallback(self.customReason)
                    } else {
                        LoggerService().log(eventName: "Preset Booking Reason Selected \(self.checkedOption)")
                        self.preBookingOptionsCallback(self.checkedOption)
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
