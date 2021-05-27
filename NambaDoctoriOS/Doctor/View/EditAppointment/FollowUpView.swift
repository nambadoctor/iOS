//
//  FollowUpView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/31/21.
//

import SwiftUI

struct FollowUpView : View {
    @ObservedObject var followUpVM:FollowUpViewModel
    var body : some View {
        VStack {
            Toggle("Set Follow-Up for patient", isOn: $followUpVM.toggleFollowUp)
                .padding(.bottom, 5)
            
            if followUpVM.toggleFollowUp  {
                HStack {
                    TextField("type here", text: $followUpVM.followUpDays)
                        .keyboardType(.numberPad)
                        .frame(width: 80, height: 20)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.trailing)

                    BubbledSelector(title: "", array: followUpVM.daysArr, selected: $followUpVM.selectedDay, limitToFour: false)
                }
            }
        }
    }
}
