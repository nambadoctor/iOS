//
//  DetailedUpcomingAppointmentView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/03/21.
//

import SwiftUI

struct DetailedUpcomingAppointmentView: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var detailedAppointmentVM:DetailedAppointmentViewModel
    @State var toggleNavBarProgressView:Bool = false

    init(intermediateVM:IntermediateAppointmentViewModel) {
        detailedAppointmentVM = DetailedAppointmentViewModel(intermediateVM: intermediateVM)
    }

    var body: some View {
        ZStack {

            detailedUpcomingAppointment

            if detailedAppointmentVM.showTwilioRoom {
                DoctorTwilioManager(DoctorTwilioVM: detailedAppointmentVM.doctorTwilioManagerViewModel)
            }

            //remote kill view trigger
            if detailedAppointmentVM.killView {
                Text("You are done").onAppear() { killView() }
            }

        }
        .background(Color.gray.opacity(0.3))
        .navigationBarItems(trailing: saveButton)
        .alert(isPresented: $detailedAppointmentVM.showOnSuccessAlert, content: {
            Alert(title: Text("Prescription Sent Successfully"), dismissButton: .default(Text("Ok"), action: { detailedAppointmentVM.takeToViewScreen() }))
        })
        .onTapGesture {
            EndEditingHelper.endEditing()
        }
    }

    var detailedUpcomingAppointment : some View {
        ScrollView (.vertical) {

            VStack {
                header
                Divider().background(Color.blue.opacity(0.4))
                
                
                
                actionButtons
            }
            .background(Color.white)
            .border(Color.blue, width: 1)
            .padding(.top, 5)

            PrescriptionsView(prescriptionsVM: self.detailedAppointmentVM.intermediateVM.prescriptionVM)
                .padding()
                .background(Color.white)

            HStack {
                Spacer()
                Button {
                    self.detailedAppointmentVM.collapseExtraDetailEntry.toggle()
                } label: {
                    Text(self.detailedAppointmentVM.collapseExtraDetailEntry ? "Show Remaining" : "Collapse Remaining")
                }
            }
            .padding(.horizontal)

            if !detailedAppointmentVM.collapseExtraDetailEntry {
                PatientInfoView(patientInfoViewModel: detailedAppointmentVM.intermediateVM.patientInfoViewModel)
                    .padding()
                    .background(Color.white)

                DoctorsSectionViewModel(serviceRequestVM: detailedAppointmentVM.intermediateVM.serviceRequestVM)
                
    //                FollowUpView(followUpVM: self.detailedAppointmentVM.followUpViewModel)
    //                    .padding()
    //                    .background(Color.white)

                ModifyFeeView(modifyFeeVM: self.detailedAppointmentVM.modifyFeeViewModel)
                    .padding()
                    .background(Color.white)

                Spacer()
            }

            sendToPatient
        }
    }

    var saveButton : some View {
        Button(action: {
            self.toggleNavBarProgressView.toggle()
            detailedAppointmentVM.savePrescription { _ in
                self.toggleNavBarProgressView.toggle()
            }
        }, label: {
            if !detailedAppointmentVM.checkIfAppointmentFinished() {
                HStack {
                    if toggleNavBarProgressView {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    Text("Save")
                }
            }
        })
    }

    var sendToPatient : some View {
        VStack {
            Button {
                EndEditingHelper.endEditing()
                detailedAppointmentVM.sendToPatient()
            } label: {
                HStack {
                    Spacer()
                    Text(detailedAppointmentVM.checkIfAppointmentFinished() ? "Amend and Send to Patient" : "Send to Patient")
                        .font(.system(size: 22))
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color.green)
                .cornerRadius(10)
                .padding()
            }
        }
    }

    var header : some View {
        VStack (alignment: .leading) {
            Text("Appointment On: \(detailedAppointmentVM.appointmentTime)")
                .foregroundColor(.blue)
                .bold()
            HStack (alignment: .top) {
                Image("person.crop.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                VStack (alignment: .leading, spacing: 5) {
                    Text(detailedAppointmentVM.customerName)
                    Text(detailedAppointmentVM.intermediateVM.patientInfoViewModel.patientAgeGenderInfo)
                    
                    Text(detailedAppointmentVM.appointmentServiceFee)
                }
                Spacer()
            }
        }.padding()
    }
    
    var actionButtons : some View {
        HStack {
            
            if !detailedAppointmentVM.consultationHappened {
                Button(action: {
                    detailedAppointmentVM.cancelAppointment { success in
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
                
                Spacer()
            }

            Button(action: {
                detailedAppointmentVM.callPatient()
            }, label: {
                VStack (alignment: .center) {
                    Image("phone")
                        .scaleEffect(1.5)
                }
            })
            
            Spacer()
            Button(action: {
                detailedAppointmentVM.startConsultation()
            }, label: {
                VStack (alignment: .center) {
                    Image(systemName: "video")
                        .scaleEffect(1.5)
                }
            })
        }
        .padding([.leading, .trailing], 50)
        .padding(.top, 10)
        .padding(.bottom, 18)
    }
    
    private func killView () {
        self.presentationMode.wrappedValue.dismiss()
    }
}
