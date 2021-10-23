//
//  IntermediateView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/4/21.
//

import SwiftUI

struct DoctorIntermediateView: View {
    @ObservedObject var intermediateVM:IntermediateAppointmentViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    init(appointment:ServiceProviderAppointment) {
        intermediateVM = IntermediateAppointmentViewModel(appointment: appointment)
    }

    var body: some View {
        ZStack {
            if intermediateVM.takeToViewAppointment {
                ViewAppointmentForDoctors()
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
        .environmentObject(intermediateVM.configurableEntryVM)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: trailingNavBarButtons)
        .onAppear() {
            self.intermediateVM.getNewChatCount()
            self.intermediateVM.checkForDirectNavigation()
        }
        .onDisappear() {
            docAutoNav.clearAllValues()
        }
    }
    
    var backButton : some View {
        Button(action : {
            if self.intermediateVM.takeToDetailedAppointment {
                self.intermediateVM.saveForLater { _ in }
            }
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
                editButton
            }

            if self.intermediateVM.configurableEntryVM.entryFieldsList.count > 1 {
                Button {
                    self.intermediateVM.changeEntryFieldSettings = true
                } label: {
                    Image("gear")
                }
                .sheet(isPresented: self.$intermediateVM.changeEntryFieldSettings) {
                    EditConfigurableEntryFieldsView(configurableEntryVM: self.intermediateVM.configurableEntryVM, showSheet: self.$intermediateVM.changeEntryFieldSettings)
                }
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
}
