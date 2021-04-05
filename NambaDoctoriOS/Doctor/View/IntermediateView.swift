//
//  IntermediateView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/4/21.
//

import SwiftUI

class IntermediateAppointmentViewModel : ObservableObject {
    @Published var appointment:ServiceProviderAppointment
    @Published var serviceRequestVM:ServiceRequestViewModel
    @Published var prescriptionVM:MedicineViewModel
    @Published var patientInfoViewModel:PatientInfoViewModel

    @Published var takeToDetailedAppointment:Bool = false
    @Published var takeToViewAppointment:Bool = false
    
    init(appointment:ServiceProviderAppointment) {
        self.appointment = appointment
        self.serviceRequestVM = ServiceRequestViewModel(appointment: appointment)
        self.prescriptionVM = MedicineViewModel(appointment: appointment)
        self.patientInfoViewModel = PatientInfoViewModel(appointment: appointment)
        
        checkDetailedOrView()
    }
    
    func fetchViewModelInits () {
        self.serviceRequestVM = ServiceRequestViewModel(appointment: appointment)
        self.prescriptionVM = MedicineViewModel(appointment: appointment)
        self.patientInfoViewModel = PatientInfoViewModel(appointment: appointment)
    }
    
    func checkDetailedOrView () {
        if appointment.status == ConsultStateK.Confirmed.rawValue || appointment.status == ConsultStateK.StartedConsultation.rawValue {
            takeToDetailed()
        } else {
            takeToView()
        }
    }
    
    func takeToDetailed () {
        self.takeToDetailedAppointment = true
        self.takeToViewAppointment = false
    }
    
    func takeToView () {
        self.takeToDetailedAppointment = false
        self.takeToViewAppointment = true
    }
}

struct IntermediateView: View {
    @ObservedObject var intermediateVM:IntermediateAppointmentViewModel
    
    init(appointment:ServiceProviderAppointment) {
        intermediateVM = IntermediateAppointmentViewModel(appointment: appointment)
    }
    
    var body: some View {
        VStack {
            if intermediateVM.takeToViewAppointment {
                ViewAppointment(intermediateVM: intermediateVM)
            } else if intermediateVM.takeToDetailedAppointment {
                DetailedUpcomingAppointmentView(intermediateVM: intermediateVM)
            }
        }
    }
}
