//
//  AddPatientAndSchedulentermediateView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/26/21.
//

import SwiftUI

struct AddPatientAndSchedulentermediateView: View {
    @ObservedObject var addPatientVM:AddPatientViewModel
    @Binding var showView:Bool
    
    var body: some View {
        ZStack {
            if addPatientVM.scheduleAppointmentToggle {
                ScheduleAppointmentForPatientView(scheduleAppointmentViewModel: self.addPatientVM.scheduleAppointmentVM, showView: self.$addPatientVM.scheduleAppointmentToggle)
                    .onAppear() {self.addPatientVM.scheduleAppointmentVM.availabilityVM.retrieveAvailabilities()}
            } else {
                AddPatientView(addPatientVM: addPatientVM)
            }
            
            if self.addPatientVM.finished {
                Text("").onAppear() {self.showView = false}
            }
        }
    }
}
