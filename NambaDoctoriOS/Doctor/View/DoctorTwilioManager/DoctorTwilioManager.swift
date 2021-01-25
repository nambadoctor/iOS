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

    init(appointment:Appointment) {
        DoctorTwilioVM = DoctorTwilioViewModel(appointment: appointment)
    }

    var body: some View {
        VStack {
            switch DoctorTwilioVM.status {
            case .started:
                TwilioViewHelper(appointmentId: DoctorTwilioVM.appointment.id)
            case .finished:
                WritePrescriptionView(appointment: DoctorTwilioVM.appointment, isNewPrescription: true)
            case .disconnected:
                Text("Disconnected").onAppear(){self.killView()}
            case .done:
                Text("Done").onAppear(){self.killView()}
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var navBarBack : some View {
        Button {
            killView()
        } label: {
            Text("< Back")
        }
    }
    
    var navPatientInfo : some View {
        Button {
            DoctorTwilioVM.viewPatientInfo()
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
