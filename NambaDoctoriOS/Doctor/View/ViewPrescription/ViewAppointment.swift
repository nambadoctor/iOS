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
            Text("Appointment Happened On: \(intermediateVM.appointmentActualStartTime)")
                .foregroundColor(.blue)
                .bold()

            HStack (alignment: .top) {
                Image("person.crop.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                VStack (alignment: .leading, spacing: 5) {
                    Text(intermediateVM.appointment.customerName)
                    
                    Text("Fee: ₹\(String(intermediateVM.appointment.serviceFee.clean))")
                    
                    Text("Reason: \(intermediateVM.serviceRequestVM.serviceRequest.reason)")
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
