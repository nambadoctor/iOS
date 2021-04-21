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
                               destination: DoctorChatRoomView(chatVM: self.intermediateVM.chatVM),
                               isActive: $intermediateVM.takeToChat)
            }
        }
        .environmentObject(intermediateVM)
        .environmentObject(intermediateVM.medicineVM)
        .environmentObject(intermediateVM.serviceRequestVM)
        .environmentObject(intermediateVM.serviceRequestVM.investigationsViewModel)
        .environmentObject(intermediateVM.patientInfoViewModel)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: trailingNavBarButtons)
        .onDisappear() {
            docAutoNav.clearAllValues()
        }
    }
    
    var backButton : some View {
        Button(action : {
            self.intermediateVM.saveForLater { _ in }
            docAutoNav.leaveIntermediateView()
            DoctorDefaultModifiers.refreshAppointments()
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "arrow.left")
                .padding([.top, .bottom, .trailing])
        }
    }
    
    var trailingNavBarButtons : some View {
        HStack {
            if intermediateVM.takeToViewAppointment {
                chatButton
                editButton
            }
        }
    }

    var editButton : some View {
        VStack {
            Button(action : {
                intermediateVM.takeToDetailed()
            }){
                Text("Edit")
                    .foregroundColor(.blue)
                    .bold()
                    .padding(5)
            }
        }
    }

    var chatButton : some View {
        Button(action: {
            self.intermediateVM.takeToChat = true
        }, label: {
            Image(systemName: "message")
                .padding(5)
        })
    }
}
