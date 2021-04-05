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
        VStack {
            if intermediateVM.takeToViewAppointment {
                ViewAppointment()
            } else if intermediateVM.takeToDetailedAppointment {
                EditableAppointmentView()
            }
        }
        .environmentObject(intermediateVM)
        .environmentObject(intermediateVM.medicineVM)
        .environmentObject(intermediateVM.serviceRequestVM)
        .environmentObject(intermediateVM.serviceRequestVM.investigationsViewModel)
        .environmentObject(intermediateVM.patientInfoViewModel)
    }
}
