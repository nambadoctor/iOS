//
//  ViewPrescription.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import SwiftUI

struct ViewAppointment: View {
    
    @EnvironmentObject var intermediateVM:IntermediateAppointmentViewModel

    var body: some View {
        ScrollView {
            VStack {
                header
                    .background(Color.white)
                    .border(Color.blue, width: 1)
                    .padding([.top, .bottom], 5)

                details

                HStack {Spacer()}
            }.padding()
        }.navigationBarItems(trailing: endAndAmendButton)
        .onAppear(){intermediateVM.refreshPrescription()} //MARK:- OPTIMIZE THIS LATER!
    }

    var header : some View {
        VStack (alignment: .leading) {
            Text("Consulted Time: \(intermediateVM.appointmentActualStartTime)")
                .foregroundColor(.blue)
                .bold()

            HStack (alignment: .top) {
                
                if intermediateVM.appointmentStarted {
                    LetterOnColoredCircle(word: intermediateVM.appointment.customerName, color: .green)
                } else {
                    LetterOnColoredCircle(word: intermediateVM.appointment.customerName, color: intermediateVM.appointmentFinished ? Color.gray : Color.blue)
                }

                VStack (alignment: .leading, spacing: 5) {
                    Text(intermediateVM.appointment.customerName)
                    
                    Text("Fee: ₹\(String(intermediateVM.appointment.serviceFee.clean)) (\(intermediateVM.isPaid ? "Paid" : "Payment Pending"))")
                    
                    ServiceRequestOverViewDetails(serviceRequestVM: intermediateVM.serviceRequestVM)
                }
                
                Spacer()
            }
        }.padding()
    }

    var details : some View {
        VStack (alignment: .leading, spacing: 5) {
            MedicineView()
            ServiceRequestView()
            InvestigationsView()
        }
    }

    var endAndAmendButton : some View {
        Button {
            intermediateVM.takeToDetailed()
        } label: {
            Text("Edit")
        }
    }
}
