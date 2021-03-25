//
//  DoctorTwilioManager.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import SwiftUI

struct DoctorTwilioManager: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var DoctorTwilioVM:DoctorTwilioViewModel

    init(appointment:ServiceProviderAppointment) {
        DoctorTwilioVM = DoctorTwilioViewModel(appointment: appointment)
    }

    var body: some View {
        VStack {
            switch DoctorTwilioVM.status {
            case .waitingToStart:
                Text("loading...").onAppear(){DoctorTwilioVM.startRoom()}
            case .started:
                TwilioViewHelper(appointmentId: DoctorTwilioVM.appointment.appointmentID)
                    .navigationBarItems(trailing: navBarTrailing)
            case .finished:
                Text("Finished").onAppear(){self.killView()}
            case .disconnected:
                Text("Disconnected").onAppear(){self.killView()}
            case .done:
                Text("Done").onAppear(){self.killView()}
            }
        }
        .onAppear(){ twilioStatusChangeListener() }
        .navigationBarBackButtonHidden(true)
    }

    var navPatientInfo : some View {
        Button {
            DoctorTwilioVM.viewPatientInfoClicked()
        } label: {
            VStack {
                Text("Patient")
                Text("Info")
            }
        }
    }
    
    var navEndConsultation : some View {
        Button {
            DoctorTwilioVM.endConsultation()
        } label: {
            VStack {
                Text("End")
                Text("Consultation")
            }
        }
    }
    
    var navBarTrailing : some View {
        HStack {
            navPatientInfo
            navEndConsultation
        }
    }

    private func killView () {
        self.presentationMode.wrappedValue.dismiss()
    }
}

extension DoctorTwilioManager {
    func twilioStatusChangeListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(DocViewStatesK.postConsultationChange)"), object: nil, queue: .main) { (_) in
            DoctorTwilioVM.toggleStatus(defaultChangeString: UserDefaults.standard.value(forKey: "\(DocViewStatesK.postConsultation)") as! String)
        }
    }
}
