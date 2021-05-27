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

            CancellationBottomsheetCaller(offset: self.$intermediateVM.cancellationSheetOffset, cancellationReasons: self.intermediateVM.DoctorCancellationReason, delegate: self.intermediateVM)
        }
        .background(Color.gray.opacity(0.08))
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
            
            ZStack {
                header
                    .background(Color(CustomColors.SkyBlue))
                    .cornerRadius(10)
                    .padding([.horizontal, .bottom])
                    .padding(.top, 7)
                    .padding(.bottom, 7)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        actionButtons
                    }
                }
            }

            MedicineEditableView()
                .modifier(DetailedAppointmentViewCardModifier())
            
            
            PatientInfoEditableView()
                .modifier(DetailedAppointmentViewCardModifier())

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

                        VStack (alignment: .leading) {
                            Text("Clinical Information")
                                .bold()
                            
                            if self.intermediateVM.collapseExtraDetailEntry {
                                Text("click to expand")
                                    .font(.footnote)
                                    .foregroundColor(Color.gray.opacity(0.5))
                            } else {
                                Text("click to collapse")
                                    .font(.footnote)
                                    .foregroundColor(Color.gray.opacity(0.5))
                            }
                        }

                        Spacer()
                    }
                }
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            
            if !intermediateVM.collapseExtraDetailEntry {
                
                ServiceRequestEditableView()
                
                InvestigationsEditableView()
                    .modifier(DetailedAppointmentViewCardModifier())
                
                AdviceEditableView()
                    .modifier(DetailedAppointmentViewCardModifier())
                
                Spacer()
            }
            
            if !intermediateVM.isPaid {
                ModifyFeeView(modifyFeeVM: self.intermediateVM.modifyFeeViewModel)
                    .modifier(DetailedAppointmentViewCardModifier())
            }
            
            HStack {
                previewPrescription
                sendToPatient
            }
            .modifier(DetailedAppointmentViewCardModifier())
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
    
    var previewPrescription : some View {
        VStack {
            LargeButton(title: "Preview",
                        backgroundColor: Color.white,
                        foregroundColor: Color.blue) {
                self.intermediateVM.previewPrescription()
            }
        }
        .sheet(isPresented: self.$intermediateVM.showPDFPreview, content: {
            PrescriptionPreviewView()
        })
    }
    
    var sendToPatient : some View {
        VStack {
            LargeButton(title: intermediateVM.appointmentFinished ? "Amend and Submit" : "Submit",
                        backgroundColor: Color.blue) {
                DoctorAlertHelpers().sendPrescriptionAlert { sendPrescription in
                    if sendPrescription {
                        EndEditingHelper.endEditing()
                        intermediateVM.sendToPatient()
                    }
                }
            }
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

    var actionButtons : some View {
        HStack (spacing: 10) {
            if !intermediateVM.appointmentFinished {
                Button(action: {
                    self.intermediateVM.showCancellationSheet()
                }, label: {
                    ZStack {
                        Image("xmark")
                            .scaleEffect(1.0)
                            .padding()
                            .foregroundColor(.red)
                            .background(Color.white)
                    }
                    .frame(width: 45, height: 45)
                    .overlay(Circle().fill(Color.red.opacity(0.3)))
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .clipShape(Circle())
                })
            }
            
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
            
            if !intermediateVM.appointmentFinished {
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

            if !intermediateVM.appointmentFinished {
                Button(action: {
                    intermediateVM.startConsultation()
                }, label: {
                    ZStack {
                        Image(systemName: "video")
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
        }
        .padding(.trailing)
        .padding(.trailing)
    }
    
    private func killView () {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct PatientOverViewDetails : View {
    @ObservedObject var patientInfoVM:PatientInfoViewModel
    var body: some View {
        HStack (spacing: 20) {
            if patientInfoVM.patientObj != nil {
                VStack (alignment: .leading) {
                    Text("Age")
                        .foregroundColor(Color.white.opacity(0.5))
                    
                    Text(patientInfoVM.patientObj.age)
                        .foregroundColor(Color.white)
                        .bold()
                }
                
                VStack (alignment: .leading) {
                    Text("Gender")
                        .foregroundColor(Color.white.opacity(0.5))
                    
                    Text(patientInfoVM.patientObj.gender)
                        .foregroundColor(Color.white)
                        .bold()
                }
            }
        }
    }
}

struct ServiceRequestOverViewDetails : View {
    @ObservedObject var serviceRequestVM:ServiceRequestViewModel
    var body: some View {
        VStack (alignment: .leading) {
            if !serviceRequestVM.serviceRequest.reason.isEmpty {
                Text("Reason")
                    .foregroundColor(Color.white.opacity(0.5))
                
                Text(serviceRequestVM.serviceRequest.reason)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
    }
}
