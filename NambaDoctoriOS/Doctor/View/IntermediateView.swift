//
//  IntermediateView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/4/21.
//

import SwiftUI

struct IntermediateView: View {
    @ObservedObject var intermediateVM:IntermediateAppointmentViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
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
                    .onAppear(){self.intermediateVM.doctorTwilioManagerViewModel.viewController?.connect(sender: intermediateVM)}
            }

            if intermediateVM.takeToChat {
                NavigationLink("",
                               destination: DoctorChatRoomView(appointment: intermediateVM.appointment),
                               isActive: $intermediateVM.takeToChat)
            }

        }
        .environmentObject(intermediateVM)
        .environmentObject(intermediateVM.medicineVM)
        .environmentObject(intermediateVM.serviceRequestVM)
        .environmentObject(intermediateVM.serviceRequestVM.investigationsViewModel)
        .environmentObject(intermediateVM.patientInfoViewModel)
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.intermediateVM.saveForLater { _ in }
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "arrow.left")
        })
    }
}
