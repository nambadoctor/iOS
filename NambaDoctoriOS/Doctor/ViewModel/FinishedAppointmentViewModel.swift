//
//  FinishedAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation

class FinishedAppointmentViewModel: ObservableObject {
    @Published var appointment:Appointment
    @Published var viewPrescription:Bool = false
    @Published var amendPrescription:Bool = false
    
    private var doctorAlertHelper:DoctorAlertHelpersProtocol

    init(appointment:Appointment,
         doctorAlertHelper:DoctorAlertHelpersProtocol = DoctorAlertHelpers()) {
        self.appointment = appointment
        self.doctorAlertHelper = doctorAlertHelper
    }

    var LocalTime:String {
        return Helpers.utcToLocal(dateStr: self.appointment.slotDateTime)
    }

    func takeToViewPrescription () {
        viewPrescription = true
    }

    func getPrescriptionViewModelToNavigate () -> PrescriptionViewModel {
        return PrescriptionViewModel(appointment: appointment, isNewPrescription: false)
    }

    func takeToAmendPrescription () {
        doctorAlertHelper.amendPrescriptionAlert { (amend) in
            self.amendPrescription = true
        }
    }
}
