//
//  ReasonPickerView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/6/21.
//

import SwiftUI

struct OneLineReasonDisplay : View {
    @EnvironmentObject var reasonPickerVM:ReasonPickerViewModel
    var body : some View {
        HStack (spacing: 3) {
            
            if DeviceSizeHelper.getIfSmallScreen() {
                ForEach(reasonPickerVM.OneLineReasonsToSHowSmallDisplay, id: \.self) { reason in
                    ReasonPickerCard(reason: reason, imageName: reasonPickerVM.getValForKey(key: reason))
                }
            } else {
                ForEach(reasonPickerVM.OneLineReasonsToSHow, id: \.self) { reason in
                    ReasonPickerCard(reason: reason, imageName: reasonPickerVM.getValForKey(key: reason))
                }
            }

            VStack {
                Text("More")
                    .font(.system(size: 12))
                Image("circle.three.horizontal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .onTapGesture {
                self.reasonPickerVM.showAllReasons = true
            }
            .padding(8)
            .frame(width: 70, height: 75)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal, 2)
            
            Spacer()
        }
        .padding(.leading, 2)

        .sheet(isPresented: self.$reasonPickerVM.showAllReasons) {
            ReasonPickerView()
                .environmentObject(reasonPickerVM)
        }
    }
}

struct ReasonPickerView: View {
    
    @EnvironmentObject var reasonPickerVM:ReasonPickerViewModel
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ScrollView {
            
            VStack (alignment: .leading) {
                Text("Your reason not here? Type your own")
                    .font(.headline)
                    .bold()
                
                ExpandingTextView(text: self.$reasonPickerVM.reason)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(reasonPickerVM.reasons.sorted(by: >), id: \.key) { key, value in
                        ReasonPickerCard(reason: key, imageName: value)
                    }
                }.padding()
            }
            
            LargeButton(title: "Done",
                        backgroundColor: Color.blue) {
                self.reasonPickerVM.reasonSelected()
            }
        }.padding()
    }
}
