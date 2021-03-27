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
                VStack {
                    if DoctorTwilioVM.collapseCall {
                        Spacer()
                    }
                    HStack {
                        if DoctorTwilioVM.collapseCall {
                            Spacer()
                        }
                        TwilioViewHelper(doctorTwilioVM: DoctorTwilioVM)
                            .navigationBarItems(trailing: collapseCall)
                            .frame(width: DoctorTwilioVM.collapseCall ? 100 : UIScreen.main.bounds.width,
                                   height: DoctorTwilioVM.collapseCall ? 180 : UIScreen.main.bounds.height - 55)
                    }
                }
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

    var collapseCall : some View {
        Button {
            DoctorTwilioVM.collapseView()
        } label: {
            Text(DoctorTwilioVM.collapseCall ? "Expand Call" : "Collapse Call")
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
