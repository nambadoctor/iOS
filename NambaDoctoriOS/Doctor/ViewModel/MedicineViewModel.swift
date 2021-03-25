//
//  MedicineViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class MedicineViewModel: ObservableObject {
    var appointment:ServiceProviderAppointment
    @Published var prescription:ServiceProviderPrescription? = nil
    
    //global alert will not show when using bottom sheet
    @Published var showLocalAlert:Bool = false

    var generalDoctorHelpers:GeneralDoctorHelpersProtocol!
    private var retrievePrescriptionHelper:PrescriptionGetSetServiceCallProtocol
    
    init(appointment:ServiceProviderAppointment,
        generalDoctorHelpers:GeneralDoctorHelpersProtocol = GeneralDoctorHelpers(),
        retrievePrescriptionHelper:PrescriptionGetSetServiceCallProtocol = PrescriptionGetSetServiceCall()) {
        self.appointment = appointment
        self.generalDoctorHelpers = generalDoctorHelpers
        self.retrievePrescriptionHelper = retrievePrescriptionHelper
            
        DispatchQueue.main.async {
            self.retrievePrescriptions()
        }
    }

    func retrievePrescriptions () {
        retrievePrescriptionHelper.getPrescription(appointmentId: self.appointment.appointmentID, serviceRequestId: self.appointment.serviceRequestID, customerId: self.appointment.customerID) { (prescription) in
            if prescription != nil {
                self.prescription = prescription!
            } else {
                self.prescription = MakeEmptyPrescription(appointment: self.appointment)
            }
        }
    }

}
