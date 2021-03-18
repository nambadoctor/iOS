//
//  FinishedAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation

class FinishedAppointmentViewModel: ObservableObject {
    @Published var appointment:ServiceProviderAppointment
    @Published var viewPrescription:Bool = false
    @Published var amendPrescription:Bool = false
    
    private var doctorAlertHelper:DoctorAlertHelpersProtocol

    init(appointment:ServiceProviderAppointment,
         doctorAlertHelper:DoctorAlertHelpersProtocol = DoctorAlertHelpers()) {
        self.appointment = appointment
        self.doctorAlertHelper = doctorAlertHelper
    }

    var LocalTime:String {
        return Helpers.getTimeFromTimeStamp(timeStamp: self.appointment.requestedTime)
    }

    func takeToViewPrescription () {
        viewPrescription = true
    }

    func getPrescriptionViewModelToNavigate () -> ServiceRequestViewModel {
        return ServiceRequestViewModel(appointment: appointment, isNewPrescription: false)
    }

    func takeToAmendPrescription () {
        doctorAlertHelper.amendPrescriptionAlert { (amend) in
            self.amendPrescription = true
        }
    }
}
