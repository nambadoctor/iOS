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
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.intermediateVM.saveForLater { _ in}
        }
    }
    
    var detailedUpcomingAppointment : some View {
        ScrollView (.vertical) {

            VStack {
                header
                actionButtons
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
            
            PatientInfoEditableView()
                .padding()
                .background(Color.white)
            
            HStack {
                Button {
                    self.intermediateVM.toggleCollapseOfClinicalInformation()
                } label: {
                    HStack {
                        if self.intermediateVM.collapseExtraDetailEntry {
                            Image("chevron.right.circle")
                                .foregroundColor(.blue)
                            
                        } else {
                            Image("chevron.down.circle")
                                .foregroundColor(.blue)
                        }
                        Text("Clinical Information")
                            .bold()
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.white)

            if !intermediateVM.collapseExtraDetailEntry {
                
                ServiceRequestEditableView()
                
                InvestigationsEditableView()
                    .padding()
                    .background(Color.white)
                
                AdviceEditableView()
                    .padding()
                    .background(Color.white)
                
                Spacer()
            }
            
            HStack {
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
                CommonDefaultModifiers.showLoader()
                intermediateVM.saveForLater { _ in
                    CommonDefaultModifiers.hideLoader()
                    DoctorAlertHelpers().isSavedAlert()
                }
            }
        }
    }
    
    var sendToPatient : some View {
        VStack {
            LargeButton(title: intermediateVM.appointmentFinished ? "Amend and Submit" : "Submit",
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
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .bold()
            }.padding(.top)
            
            Divider().background(Color.blue.opacity(0.4))
            
            HStack (alignment: .center) {
                
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
                }.padding(.horizontal)
                Spacer()
            }
            
            Divider().background(Color.blue.opacity(0.4))
        }.padding(.horizontal)
    }
    
    var actionButtons : some View {
        HStack {
            
            if !intermediateVM.appointmentStarted && !intermediateVM.appointmentFinished {
                Button(action: {
                    intermediateVM.cancelAppointment { success in
                        if success {
                            killView()
                        }
                    }
                }, label: {
                    ZStack {
                        Image("xmark")
                            .scaleEffect(1.2)
                            .padding()
                            .foregroundColor(.red)
                    }
                    .overlay(Circle()
                                .fill(Color.red.opacity(0.2))
                                .frame(width: 60, height: 60))
                })
                Spacer()
            }
            
            Button(action: {
                self.intermediateVM.takeToChat = true
            }, label: {
                ZStack {
                    Image(systemName: "message")
                        .scaleEffect(1.2)
                        .padding()
                }
                .overlay(Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 60, height: 60))
            })
            
            Spacer()
            
            if !intermediateVM.appointmentFinished {
                Button(action: {
                    intermediateVM.patientInfoViewModel.callPatient()
                }, label: {
                    ZStack {
                        Image("phone")
                            .scaleEffect(1.2)
                            .padding()
                    }
                    .overlay(Circle()
                                .fill(Color.blue.opacity(0.2))
                                .frame(width: 60, height: 60))
                })
            }
            
            Spacer()
            
            if !intermediateVM.appointmentFinished {
                Button(action: {
                    intermediateVM.startConsultation()
                }, label: {
                    ZStack {
                        Image(systemName: "video")
                            .scaleEffect(1.2)
                            .padding()
                    }
                    .overlay(Circle()
                                .fill(Color.blue.opacity(0.2))
                                .frame(width: 60, height: 60))
                })
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical)
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
        VStack {
            if !serviceRequestVM.serviceRequest.reason.isEmpty {
                Text("Reason: \(serviceRequestVM.serviceRequest.reason)")
            }
        }
    }
}
