//
//  MakeFollowUpAppointmentView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import SwiftUI

struct MakeFollowUpAppointmentView: View {

    @ObservedObject var followUpAppointmentVM:FollowUpAppointmentViewModel
    
    var body: some View {
        Section(header: Text("Patient Followup(optional)")) {
            Toggle("Set Follow-Up for patient", isOn: $followUpAppointmentVM.needFollowUp)

            if followUpAppointmentVM.needFollowUp  {
                HStack {
                    TextField("Enter number here", text: $followUpAppointmentVM.validDaysHelperString)
                        .keyboardType(.numberPad)
                    
                    Picker(selection: $followUpAppointmentVM.timeIndex, label: Text("")) {
                        ForEach(0 ..< timeOptions.count) {
                            Text(timeOptions[$0])
                        }
                    }
                }

                HStack {
                    Text("₹")
                    TextField("Fee for followup", text: $followUpAppointmentVM.nextFeeHelperString)
                        .keyboardType(.numberPad)
                }
            }
        }
    }
}
