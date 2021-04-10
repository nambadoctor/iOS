//
//  DetailedUpcomingAppointmentView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/03/21.
//

import SwiftUI

struct EditableAppointmentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var intermediateVM:IntermediateAppointmentViewModel
    @State private var toggleNavBarProgressView:Bool = false
    
    var body: some View {
        ZStack {
            detailedUpcomingAppointment
            
            //remote kill view trigger
            if intermediateVM.killView {
                Text("You are done").onAppear() { killView() }
            }
        }
        .background(Color.gray.opacity(0.3))
        .navigationBarItems(trailing: Text(""))
        .alert(isPresented: $intermediateVM.showOnSuccessAlert, content: {
            Alert(title: Text("Prescription Sent Successfully"), dismissButton: .default(Text("Ok"), action: { intermediateVM.takeToView() }))
        })
        .onTapGesture {
            EndEditingHelper.endEditing()
        }
    }
    
    var detailedUpcomingAppointment : some View {
        ScrollView (.vertical) {
            
            VStack {
                header
                
                
                if !intermediateVM.appointmentFinished {
                    Divider().background(Color.blue.opacity(0.4))
                    actionButtons
                }
            }
            .background(Color.white)
            .border(Color.blue, width: 1)
            .padding(.top, 5)
            
            MedicineEditableView()
                .padding()
                .background(Color.white)
            
            if !intermediateVM.isPaid {
                ModifyFeeView(modifyFeeVM: self.intermediateVM.modifyFeeViewModel)
                    .padding()
                    .background(Color.white)
            }

            HStack {
                Button {
                    self.intermediateVM.collapseExtraDetailEntry.toggle()
                } label: {
                    Text(self.intermediateVM.collapseExtraDetailEntry ? "Clinical Information +" : "Clinical Information -")
                }
                Spacer()
            }
            .padding(.vertical, 2)
            .padding(.horizontal)
            .background(Color.white)
            
            if !intermediateVM.collapseExtraDetailEntry {

                PatientInfoEditableView()
                    .padding()
                    .background(Color.white)

                ServiceRequestEditableView()
                
                InvestigationsEditableView()
                    .padding()
                    .background(Color.white)
                
                Spacer()
            }

            HStack {
                saveButton
                sendToPatient
            }
            .padding()
            .background(Color.white)
        }
    }

    var saveButton : some View {
        VStack {
            LargeButton(title: "Save For Later",
                        backgroundColor: Color.white,
                        foregroundColor: Color.blue) {
                self.toggleNavBarProgressView.toggle()
                intermediateVM.savePrescription { _ in
                    self.toggleNavBarProgressView.toggle()
                }
            }
        }
    }

    var sendToPatient : some View {
        VStack {
            LargeButton(title: intermediateVM.appointmentFinished ? "Amend and Submit" : "Save and Submit",
                        backgroundColor: Color.blue) {
                EndEditingHelper.endEditing()
                intermediateVM.sendToPatient()
            }
        }
    }

    var header : some View {
        VStack (alignment: .leading) {
            VStack {
                Text("Appointment On: \(intermediateVM.appointmentScheduledStartTime)")
                    .foregroundColor(.gray)
                    .bold()
            }

            Divider()
            HStack (alignment: .top) {

                if intermediateVM.appointmentStarted {
                    LetterOnColoredCircle(word: intermediateVM.appointment.customerName, color: .green)
                        .padding(.vertical)
                } else {
                    LetterOnColoredCircle(word: intermediateVM.appointment.customerName, color: intermediateVM.appointmentFinished ? Color.gray : Color.blue)
                        .padding(.vertical)
                }

                VStack (alignment: .leading, spacing: 5) {
                    Text(intermediateVM.customerName)
                    PatientOverViewDetails(patientInfoVM: intermediateVM.patientInfoViewModel) //age,gender display
                    Text(intermediateVM.appointmentServiceFee)
                    ServiceRequestOverViewDetails(serviceRequestVM: intermediateVM.serviceRequestVM)
                }
                Spacer()
            }
        }.padding()
    }

    var actionButtons : some View {
        HStack {

            if !intermediateVM.appointmentStarted {
                Button(action: {
                    intermediateVM.cancelAppointment { success in
                        if success {
                            killView()
                        }
                    }
                }, label: {
                    Text("Cancel")
                        .padding([.top, .bottom], 7)
                        .padding([.leading, .trailing], 10)
                        .overlay(RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.blue, lineWidth: 2))
                })
            }

            Spacer()

            Button(action: {
                intermediateVM.patientInfoViewModel.callPatient()
            }, label: {
                HStack (alignment: .center) {
                    Image("phone")
                        .scaleEffect(1.5)
                }
            })

            Spacer()

            if !intermediateVM.appointmentFinished {
                Button(action: {
                    intermediateVM.startConsultation()
                }, label: {
                    VStack (alignment: .center) {
                        Image(systemName: "video")
                            .scaleEffect(1.5)
                    }
                })
            }
        }
        .padding([.leading, .trailing], 50)
        .padding(.top, 10)
        .padding(.bottom, 18)
    }
    
    private func killView () {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct PatientOverViewDetails : View {
    @ObservedObject var patientInfoVM:PatientInfoViewModel
    var body: some View {
        Text(patientInfoVM.briefPatientDetails)
    }
}

struct ServiceRequestOverViewDetails : View {
    @ObservedObject var serviceRequestVM:ServiceRequestViewModel
    var body: some View {
        Text("Reason: \(serviceRequestVM.serviceRequest.reason)")
    }
}
