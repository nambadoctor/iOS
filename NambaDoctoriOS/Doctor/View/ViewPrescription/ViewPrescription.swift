//
//  ViewPrescription.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import SwiftUI

struct ViewPrescription: View {

    @ObservedObject var serviceRequestVM: ServiceRequestViewModel
    @ObservedObject var investigationsVM: InvestigationsViewModel
    @ObservedObject var medicineVM: MedicineViewModel

    var body: some View {
        VStack {
            ViewPrescriptionForm
        }
    }

    var ViewPrescriptionForm : some View {
        Form {
            Section(header: Text("Examination")) { Text(serviceRequestVM.serviceRequest.examination) }
            Section(header: Text("Diagnosis")) { Text(serviceRequestVM.serviceRequest.diagnosis.name) }
            Section(header: Text("Advise")) { Text(serviceRequestVM.serviceRequest.advice) }

            Section(header: Text("Investigations")) {
                if !investigationsVM.investigations.isEmpty {
                    ForEach(Array(investigationsVM.investigations.enumerated()), id: \.0) { i, _ in
                        if !investigationsVM.investigations[i].isEmpty {
                            HStack {
                                Text("\(self.investigationsVM.investigations[i])")
                            }
                        }
                    }
                } else {
                    Text("No Investigations")
                }
            }
            
            Section(header: Text("Prescription")) {
                
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

            }
        }
    }
}
