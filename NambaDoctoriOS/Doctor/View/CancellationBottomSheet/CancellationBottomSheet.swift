//
//  CancellationBottomSheet.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/19/21.
//

import SwiftUI

protocol DoctorCancellationDelegate {
    func cancel(reasonName:String)
}

struct CancellationBottomSheet : View {
    
    @Binding var bottomSheetOffset : CGFloat
    var delegate:DoctorCancellationDelegate

    @State private var checkedOption:String = ""

    var body : some View{

        VStack(spacing: 15){
            
            HStack {
                Image("reportAbuse").foregroundColor(Color(UIColor.Red))
                
                Text("Cancel Appointment") .font(Font.system(size:15).weight(.bold))
                    .foregroundColor(Color.black)
                
                Spacer()
            }

            Text("Please select one of the below before cancelling")
                 .font(Font.system(size:14))
                .foregroundColor(Color(UIColor.lightGray))
            
            VStack {
                CheckboxField(
                    label: "This is not my specialty",
                    size: 14,
                    textSize: 14,
                    callback: checkboxSelected,
                    checkedOption: self.$checkedOption
                )
                CheckboxField(
                    label: "I am not available at this time",
                    size: 14,
                    textSize: 14,
                    callback: checkboxSelected,
                    checkedOption: self.$checkedOption
                )
                CheckboxField(
                    label: "Patient did not pick up",
                    size: 14,
                    textSize: 14,
                    callback: checkboxSelected,
                    checkedOption: self.$checkedOption
                )
                CheckboxField(
                    label: "Technical Issues",
                    size: 14,
                    textSize: 14,
                    callback: checkboxSelected,
                    checkedOption: self.$checkedOption
                )
                CheckboxField(
                    label: "Other",
                    size: 14,
                    textSize: 14,
                    callback: checkboxSelected,
                    checkedOption: self.$checkedOption
                )
            }
            
            HStack {
                Spacer()
                Button ("Back") {
                    self.bottomSheetOffset = UIScreen.main.bounds.height
                } .font(Font.system(size:13)).foregroundColor(Color(UIColor.gray)).padding(.trailing, 10)
                
                Button ("Confirm") {
                    self.delegate.cancel(reasonName: self.checkedOption)
                }.frame(width: 90, height: 33)
                    .background(Color(UIColor.red))
                     .font(Font.system(size:13))
                    .foregroundColor(.white)
                     .font(Font.system(size:13))
                    .cornerRadius(4)
            }

        }.padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .padding(.horizontal)
            .padding(.top,20)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(25)
    }
    
    func checkboxSelected(id: String) {
        self.checkedOption = id
    }
}
