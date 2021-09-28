//
//  DetailedAppointmentViewForSecretary.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/29/21.
//

import SwiftUI

struct DetailedAppointmentViewForSecretary: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var intermediateVM:IntermediateAppointmentViewModel

    var body: some View {
        ScrollView {
            VStack {
                
                Spacer().frame(height: 5)
                
                ZStack {
                    header
                        .background(Color(CustomColors.SkyBlue))
                        .cornerRadius(10)
                        .padding([.horizontal, .bottom])

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            actionButtons
                        }
                    }
                }
                details
                HStack {Spacer()}
            }
        }
        .environmentObject(intermediateVM)
        .environmentObject(intermediateVM.medicineVM)
        .environmentObject(intermediateVM.serviceRequestVM)
        .environmentObject(intermediateVM.serviceRequestVM.investigationsViewModel)
        .environmentObject(intermediateVM.patientInfoViewModel)
        .background(Color.gray.opacity(0.08))
        .onAppear(){intermediateVM.refreshPrescription()} //MARK:- OPTIMIZE THIS LATER!
        .navigationBarItems(trailing: saveNavButton)
    }
    
    var saveNavButton : some View {
        Button {
            CommonDefaultModifiers.showLoader(incomingLoadingText: "Saving Customer Vitals")
            self.intermediateVM.serviceRequestVM.sendToPatient { success, serviceRequestId in
                if success {
                    CommonDefaultModifiers.hideLoader()
                    DoctorAlertHelpers().customerVitalsSavedAlert()
                }
            }
        } label: {
            Text("Save")
        }

    }
    
    var header : some View {
        VStack (alignment: .leading) {
            
            if self.intermediateVM.childProfile == nil {
                forCareTakerHeader
            } else {
                forChildHeader
            }
        }
        .padding([.horizontal, .top])
        .padding(.bottom, 40)
    }
    
    var forCareTakerHeader : some View {
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
                    .foregroundColor(Color.white)
                    .bold()
                
                HStack (spacing: 20) {
                    
                    PatientOverViewDetails(patientInfoVM: intermediateVM.patientInfoViewModel) //age,gender display
                    
                    VStack (alignment: .leading) {
                        Text("Fee")
                            .foregroundColor(Color.white.opacity(0.5))
                        
                        Text(intermediateVM.appointmentServiceFee)
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }

                ServiceRequestOverViewDetails(serviceRequestVM: intermediateVM.serviceRequestVM)
                
            }.padding(.horizontal)
            Spacer()
        }
    }
    
    var forChildHeader : some View {
        HStack (alignment: .center) {
            
            if intermediateVM.appointmentStarted {
                LetterOnColoredCircle(word: intermediateVM.childProfile!.Name, color: .green)
                    .padding(.vertical)
            } else {
                LetterOnColoredCircle(word: intermediateVM.childProfile!.Name, color: intermediateVM.appointmentFinished ? Color.gray : Color.blue)
                    .padding(.vertical)
            }

            VStack (alignment: .leading, spacing: 5) {
                Text(intermediateVM.childProfile!.Name)
                    .foregroundColor(Color.white)
                    .bold()
                
                HStack (spacing: 20) {
                    
                    VStack (alignment: .leading) {
                        Text("Age")
                            .foregroundColor(Color.white.opacity(0.5))
                        
                        Text(intermediateVM.childProfile!.Age)
                            .foregroundColor(Color.white)
                            .bold()
                    }
                    
                    VStack (alignment: .leading) {
                        Text("Gender")
                            .foregroundColor(Color.white.opacity(0.5))
                        
                        Text(intermediateVM.childProfile!.Gender)
                            .foregroundColor(Color.white)
                            .bold()
                    }
                    
                    VStack (alignment: .leading) {
                        Text("Fee")
                            .foregroundColor(Color.white.opacity(0.5))
                        
                        Text(intermediateVM.appointmentServiceFee)
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }

                ServiceRequestOverViewDetails(serviceRequestVM: intermediateVM.serviceRequestVM)
                
                
                HStack {
                    Text("Booked by \(self.intermediateVM.patientInfoViewModel.patientObj.firstName)")
                        .foregroundColor(Color.white)
                        .bold()
                        .padding(.top, 5)
                    Spacer()
                }
                
            }.padding(.horizontal)
            
            Spacer()
        }
    }


    var details : some View {
        VStack (alignment: .leading, spacing: 10) {
            
            CustomerVitalsEditableView()
                .environmentObject(self.intermediateVM.configurableEntryVM)
            
            MedicineView()
                .modifier(DetailedAppointmentViewCardModifier())
            
            MedicalHistoriesView()
                .modifier(DetailedAppointmentViewCardModifier())
            
            PatientReportsView()
                .modifier(DetailedAppointmentViewCardModifier())
            
            ServiceRequestView()
                .modifier(DetailedAppointmentViewCardModifier())
            
            InvestigationsView()
                .modifier(DetailedAppointmentViewCardModifier())
            
            AdviceView()
                .modifier(DetailedAppointmentViewCardModifier())
        }
    }
    
    var actionButtons : some View {
        HStack (spacing: 10) {
            
            Button(action: {
                self.intermediateVM.takeToChat = true
            }, label: {
                ZStack {
                    Image(systemName: "message")
                        .scaleEffect(1.0)
                        .padding()
                        .foregroundColor(.green)
                        .background(Color.white)

                    if self.intermediateVM.newChats > 0 {
                        Text("\(self.intermediateVM.newChats)")
                            .font(.subheadline)
                            .foregroundColor(.green)
                            .padding(.bottom, 2)
                    }
                }
                .frame(width: 45, height: 45)
                .overlay(Circle().fill(Color.green.opacity(0.3)))
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                .clipShape(Circle())
            })
            
//            Button(action: {
//                LoggerService().log(eventName: "Tranfer Appointment Button Pressed")
//                self.intermediateVM.showTransferAppointmentSheet = true
//            }, label: {
//                ZStack {
//                    Image("arrow.left.arrow.right")
//                        .scaleEffect(1.0)
//                        .padding()
//                        .background(Color.white)
//                }
//                .frame(width: 45, height: 45)
//                .overlay(Circle().fill(Color.blue.opacity(0.3)))
//                .overlay(Circle().stroke(Color.white, lineWidth: 3))
//                .clipShape(Circle())
//            })
//            .sheet(isPresented: self.$intermediateVM.showTransferAppointmentSheet) {
//                TransferAppointmentSheet(currentAppointment: self.intermediateVM.appointment, killView: killView)
//            }
            
            Button(action: {
                intermediateVM.patientInfoViewModel.callPatient()
            }, label: {
                ZStack {
                    Image("phone")
                        .scaleEffect(1.0)
                        .padding()
                        .background(Color.white)
                }
                .frame(width: 45, height: 45)
                .overlay(Circle().fill(Color.blue.opacity(0.3)))
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                .clipShape(Circle())
            })
        }
        .padding(.trailing)
        .padding(.trailing)
    }
    
    func killView () {
        presentationMode.wrappedValue.dismiss()
    }
}
