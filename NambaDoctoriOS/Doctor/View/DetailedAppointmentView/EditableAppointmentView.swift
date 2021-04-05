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
        //.navigationBarItems(trailing: saveButton)
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
                Divider().background(Color.blue.opacity(0.4))
                
                actionButtons
            }
            .background(Color.white)
            .border(Color.blue, width: 1)
            .padding(.top, 5)
            
            MedicineEditableView()
                .padding()
                .background(Color.white)
            
            ModifyFeeView(modifyFeeVM: self.intermediateVM.modifyFeeViewModel)
                .padding()
                .background(Color.white)
            
            HStack {
                Spacer()
                Button {
                    self.intermediateVM.collapseExtraDetailEntry.toggle()
                } label: {
                    Text(self.intermediateVM.collapseExtraDetailEntry ? "Show Remaining" : "Collapse Remaining")
                }
            }
            .padding(.horizontal)
            
            if !intermediateVM.collapseExtraDetailEntry {
                
                PatientInfoEditableView()
                    .padding()
                    .background(Color.white)
                
                ServiceRequestEditableView()
                    .padding()
                    .background(Color.white)
                
                InvestigationsEditableView()
                    .padding()
                    .background(Color.white)
                
                Spacer()
            }
            
            sendToPatient
        }
    }
    
    //    var saveButton : some View {
    //        Button(action: {
    //            self.toggleNavBarProgressView.toggle()
    //            detailedAppointmentVM.savePrescription { _ in
    //                self.toggleNavBarProgressView.toggle()
    //            }
    //        }, label: {
    //            if !detailedAppointmentVM.checkIfAppointmentFinished() {
    //                HStack {
    //                    if toggleNavBarProgressView {
    //                        ProgressView()
    //                            .progressViewStyle(CircularProgressViewStyle())
    //                    }
    //                    Text("Save")
    //                }
    //            }
    //        })
    //    }
    
    var sendToPatient : some View {
        VStack {
            Button {
                EndEditingHelper.endEditing()
                intermediateVM.sendToPatient()
            } label: {
                HStack {
                    Spacer()
                    Text(intermediateVM.appointmentFinished ? "Amend and Send to Patient" : "Send to Patient")
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
            Text("Appointment On: \(intermediateVM.appointmentTime)")
                .foregroundColor(.blue)
                .bold()
            HStack (alignment: .top) {
                Image("person.crop.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                VStack (alignment: .leading, spacing: 5) {
                    Text(intermediateVM.customerName)
                    Text(intermediateVM.patientInfoViewModel.patientAgeGenderInfo)
                    
                    Text(intermediateVM.appointmentServiceFee)
                }
                Spacer()
            }
        }.padding()
    }
    
    var actionButtons : some View {
        HStack {
            if !intermediateVM.appointmentFinished {
                
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
        }
        .padding([.leading, .trailing], 50)
        .padding(.top, 10)
        .padding(.bottom, 18)
    }
    
    private func killView () {
        self.presentationMode.wrappedValue.dismiss()
    }
}
