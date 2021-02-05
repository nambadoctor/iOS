//
//  DoctorTwilioViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation
import SwiftUI

class DoctorTwilioViewModel: ObservableObject {
    var appointment:Nambadoctor_V1_AppointmentObject
    @Published var status:TwilioStateK = .started
    
    private var docAlertHelpers:DoctorAlertHelpersProtocol!
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()

    init(appointment:Nambadoctor_V1_AppointmentObject) {
        self.appointment = appointment
        docAlertHelpers = DoctorAlertHelpers()
    }

    func toggleStatus (defaultChangeString: String) {
        switch defaultChangeString {
        case TwilioStateK.started.rawValue:
            status = .started
        case TwilioStateK.done.rawValue:
            status = .done
        case TwilioStateK.finished.rawValue:
            status = .finished
        case TwilioStateK.disconnected.rawValue:
            self.disconnect()
        default:
            status = .started
        }
    }

    func disconnect() {
        let localStatus = UserDefaults.standard.value(forKey: "\(DocViewStatesK.endConsultationAlert)") ?? false
        
        guard localStatus as! Bool == false else {
            self.status = .disconnected
            return
        }

        docAlertHelpers.endConsultationAlert { (endConsultation) in
            self.status = .disconnected
        } dontShowAgain: { (dontShowAgain) in
            DoctorDefaultModifiers.endConsultAlertDoNotShow()
            self.status = .disconnected
        }
    }
    
    func endConsultation() {
        status = .finished
    }
    
    func viewPatientInfo() {
        docSheetHelper.showPatientInfoSheet(appointment: appointment)
    }
}
