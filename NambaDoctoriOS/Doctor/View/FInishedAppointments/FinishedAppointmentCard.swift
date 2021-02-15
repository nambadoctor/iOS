//
//  FinishedAppointmentCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import SwiftUI

struct FinishedAppointmentCard: View {
    
    @ObservedObject private var AppointmentVM:FinishedAppointmentViewModel
    var prescriptionVM:PrescriptionViewModel

    init(appointment:Appointment) {
        AppointmentVM = FinishedAppointmentViewModel(appointment: appointment)
        prescriptionVM = PrescriptionViewModel(appointment: appointment, isNewPrescription: false)
    }

    var body: some View {
        VStack (alignment: .leading) {
            Text(AppointmentVM.appointment.patientName)
            Text(AppointmentVM.LocalTime)

            HStack {
                Button {
                    AppointmentVM.takeToViewPrescription()
                } label: {
                    Text("view")
                }
                Button {
                    AppointmentVM.takeToAmendPrescription()
                } label: {
                    Text("amend")
                }
            }

            NavigationLink("",
                           destination: ViewPrescription(prescriptionVM: AppointmentVM.getPrescriptionViewModelToNavigate()),
                           isActive: $AppointmentVM.viewPrescription)

            NavigationLink("",
                           destination: WritePrescriptionView(appointment: AppointmentVM.appointment, isNewPrescription: false),
                           isActive: $AppointmentVM.amendPrescription)
        }
    }
}
