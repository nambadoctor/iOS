//
//  PrescriptionsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/03/21.
//

import SwiftUI

struct PrescriptionsView: View {
    
    @ObservedObject var prescriptionsVM:MedicineViewModel
    var body: some View {
        prescriptions
    }
    
    var prescriptions : some View {
        VStack (alignment: .leading) {
            
            Text("PRESCRIPTION:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            ForEach (prescriptionsVM.prescription.medicineList, id: \.medicineName) { medicine in
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
                    
                    VStack (spacing: 15) {
                        Button {
                            prescriptionsVM.editPrescription(medicine: medicine)
                        } label: {
                            Image("pencil")
                                .foregroundColor(Color.green)
                        }
                        
                        Button {
                            prescriptionsVM.removePrescription(medicine: medicine)
                        } label: {
                            Image("xmark.circle")
                                .foregroundColor(Color.green)
                        }
                    }

                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(7)
            }
            
            HStack {
                
                LargeButton(title: "Add Manually",
                            backgroundColor: Color.white,
                            foregroundColor: Color.yellow) {
                    prescriptionsVM.uploadManually()
                }
                
                LargeButton(title: "Upload Image",
                            backgroundColor: Color.green) {
                    print("Hello World")
                }
            }
        }
        .sheet(isPresented: $prescriptionsVM.showMedicineEntrySheet) {
            MedicineEntryView(medicineVM: prescriptionsVM)
        }
    }
}
