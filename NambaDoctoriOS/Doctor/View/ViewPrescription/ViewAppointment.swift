//
//  ViewPrescription.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import SwiftUI

struct ViewAppointment: View {
    
    @ObservedObject var intermediateVM: IntermediateAppointmentViewModel
    @ObservedObject var serviceRequestVM: ServiceRequestViewModel
    @ObservedObject var investigationsVM: InvestigationsViewModel
    @ObservedObject var medicineVM: MedicineViewModel
    
    init(intermediateVM:IntermediateAppointmentViewModel) {
        self.intermediateVM = intermediateVM
        self.serviceRequestVM = intermediateVM.serviceRequestVM
        self.investigationsVM = intermediateVM.serviceRequestVM.investigationsViewModel
        self.medicineVM = intermediateVM.prescriptionVM
    }

    var body: some View {
        ScrollView {
            VStack {
                header
                    .background(Color.white)
                    .border(Color.blue, width: 1)
                    .padding([.top, .bottom], 5)
                
                HStack {
                    Image("checkmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.green)
                        .padding(.trailing)
                    
                    Text("Prescription Sent on \(Helpers.getTimeFromTimeStamp(timeStamp: medicineVM.prescription.createdDateTime))")

                    Spacer()
                }

                Spacer().frame(height: 10)
                
                details
                
                HStack {Spacer()}
            }.padding()
        }
    }

    var header : some View {
        VStack (alignment: .leading) {
            Text("Appointment On: \(Helpers.getTimeFromTimeStamp(timeStamp: intermediateVM.appointment.actualAppointmentStartTime))")
                .foregroundColor(.blue)
                .bold()

            HStack (alignment: .top) {
                Image("person.crop.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                VStack (alignment: .leading, spacing: 5) {
                    Text(intermediateVM.appointment.customerName)
                    //Text(patientInfoViewModel.patientAgeGenderInfo)
                    
                    Text("Fee: ₹\(String(intermediateVM.appointment.serviceFee.clean))")
                }
                Spacer()
            }
        }.padding()
    }
    
    var details : some View {
        VStack (alignment: .leading, spacing: 5) {
            
            Group {
                Text("Examination")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text(serviceRequestVM.serviceRequest.examination)
                
                Spacer().frame(height: 5)
                
                Text("Examination")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text(serviceRequestVM.serviceRequest.diagnosis.name)
                
                Spacer().frame(height: 5)
                
                Text("Examination")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text(serviceRequestVM.serviceRequest.advice)
                
                Spacer().frame(height: 5)
            }

            Text("Investigations")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            
            Spacer().frame(height: 5)
            
            if !investigationsVM.investigations.isEmpty {
                ForEach(Array( investigationsVM.investigations.enumerated()), id: \.0) { i, _ in
                    if !investigationsVM.investigations[i].isEmpty {
                        HStack {
                            Text("\(self.investigationsVM.investigations[i])")
                            Divider()
                        }
                    }
                }
            } else {
                Text("No Investigations")
            }
            
            Spacer().frame(height: 5)
            
            Text("Prescriptions")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            
            ForEach (medicineVM.prescription.medicineList, id: \.medicineName) { medicine in
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        Text("\(medicine.medicineName) - \(medicine.dosage)")
                            .font(.callout)
                            .bold()
                            .foregroundColor(Color.green)
                        
                        if !medicine.routeOfAdministration.isEmpty {
                            Text("\(medicine.routeOfAdministration)")
                                .font(.callout)
                                .foregroundColor(Color.green)
                        }
                        
                        if !medicine.intake.isEmpty {
                            Text("\(medicine.intake)")
                                .font(.callout)
                                .foregroundColor(Color.green)
                        }
                        
                        if !medicine.specialInstructions.isEmpty {
                            Text("\(medicine.specialInstructions)")
                                .font(.callout)
                                .foregroundColor(Color.green)
                        }
                    }
                    Spacer()
                    
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(7)
            }
            
            if !medicineVM.prescription.fileInfo.MediaImage.isEmpty {
                HStack {
                    Spacer()
                    ImageView(withURL: medicineVM.prescription.fileInfo.MediaImage)
                        .frame(width: 150, height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    Spacer()
                }
            }

        }.navigationBarItems(trailing: endAndAmendButton)
    }
    
    var endAndAmendButton : some View {
        Button {
            intermediateVM.takeToDetailed()
        } label: {
            Text("Edit")
        }
    }
}
