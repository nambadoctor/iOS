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
                
                Spacer().frame(height: 5)
                
                header
                    .background(Color.white)

                details
                HStack {Spacer()}
            }
        }
        .background(Color.gray.opacity(0.3))
        .onAppear(){intermediateVM.refreshPrescription()} //MARK:- OPTIMIZE THIS LATER!
    }

    var header : some View {
        VStack (alignment: .leading, spacing: 10) {
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
                    
                    Text("Fee: ₹\(String(intermediateVM.appointment.serviceFee.clean))")
                    
                    ServiceRequestOverViewDetails(serviceRequestVM: intermediateVM.serviceRequestVM)
                }
                .padding(5)
                
                Spacer()
            }
        }.padding()
    }

    var details : some View {
        VStack (alignment: .leading, spacing: 5) {
            MedicineView()
                .background(Color.white)
            
            MedicalHistoriesView()
                .background(Color.white)
            
            PatientReportsView()
                .background(Color.white)
            
            ServiceRequestView()
                .background(Color.white)
            
            InvestigationsView()
                .background(Color.white)
            
            AdviceView()
                .background(Color.white)
        }
    }
}
