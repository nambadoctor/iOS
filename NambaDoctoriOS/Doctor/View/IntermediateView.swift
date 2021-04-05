//
//  IntermediateView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/4/21.
//

import SwiftUI

struct IntermediateView: View {
    @ObservedObject var intermediateVM:IntermediateAppointmentViewModel

    init(appointment:ServiceProviderAppointment) {
        intermediateVM = IntermediateAppointmentViewModel(appointment: appointment)
    }

    var body: some View {
        ZStack {
            
            if intermediateVM.takeToViewAppointment {
                ViewAppointment()
            } else if intermediateVM.takeToDetailedAppointment {
                EditableAppointmentView()
            }
            
            if intermediateVM.showTwilioRoom {
                DoctorTwilioManager(DoctorTwilioVM: intermediateVM.doctorTwilioManagerViewModel)
            }
        }
        .environmentObject(intermediateVM)
        .environmentObject(intermediateVM.medicineVM)
        .environmentObject(intermediateVM.serviceRequestVM)
        .environmentObject(intermediateVM.serviceRequestVM.investigationsViewModel)
        .environmentObject(intermediateVM.patientInfoViewModel)
    }
}
