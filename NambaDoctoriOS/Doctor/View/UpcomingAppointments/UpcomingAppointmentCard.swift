//
//  UpcomingAppointmentCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import SwiftUI

struct UpcomingAppointmentCard: View {

    @ObservedObject private var AppointmentVM:UpcomingAppointmentViewModel

    init(appointment:Appointment) {
        AppointmentVM = UpcomingAppointmentViewModel(appointment: appointment)
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text(AppointmentVM.appointment.patientName)
            Text("On: \(AppointmentVM.LocalTime)")
            
            HStack (alignment: .center) {
                
                if AppointmentVM.showCancelButton {
                    cancelAppointmentButton
                    Spacer()
                }

                patientInfoButton
                Spacer()
                
                writePrescriptionButton
                Spacer()
                
                if !AppointmentVM.consultationDone {
                    startConsultationButton
                }
            }

            NavigationLink("",
                           destination: WritePrescriptionView(appointment: AppointmentVM.appointment, isNewPrescription: true),
                           isActive: $AppointmentVM.takeToWritePrescription)
            
            NavigationLink("",
                           destination: DoctorTwilioManager(appointment: AppointmentVM.appointment),
                           isActive: $AppointmentVM.takeToTwilioRoom)
            
        }
        .padding([.leading, .trailing])
        .background(AppointmentVM.cardBackgroundColor)
        .cornerRadius(10)
        .padding(10)
        .shadow(radius: 5)
    }
    
    var cancelAppointmentButton : some View {
        Button (action: {
            AppointmentVM.cancelAppointment()
        }) {
            VStack (alignment: .center) {
                Image("xmark.circle")
                Text("Cancel").font(.system(size: 13))
                Text("appointment").font(.system(size: 13))
            }
        }
    }
    
    var patientInfoButton : some View {
        Button (action: {
            AppointmentVM.viewPatientInfo()
        }) {
            VStack (alignment: .center) {
                Image("info.circle")
                Text("patient").font(.system(size: 13))
                Text("info").font(.system(size: 13))
            }
        }
    }

    var writePrescriptionButton : some View {
        Button (action: {
            AppointmentVM.writePrescription()
        }) {
            VStack (alignment: .center){
                Image("text.badge.checkmark")
                Text("Write").font(.system(size: 13))
                Text("Prescription").font(.system(size: 13))
            }
        }
    }
    
    var startConsultationButton : some View {
        Button (action: {
            TwilioAlertHelpers.TwilioRoomShowLoadingAlert {_ in 
                AppointmentVM.startConsultation()
            }
        }) {
            VStack (alignment: .center) {
                if !AppointmentVM.consultationDone {
                    Image("arrowshape.turn.up.right.fill")
                    if AppointmentVM.consultationStarted {
                        Text("Re-Join").font(.system(size: 13))
                    } else {
                        Text("Join").font(.system(size: 13))
                    }
                    Text("Consultation").font(.system(size: 13))
                    Text("Room").font(.system(size: 13))
                }
            }
        }

    }
}
