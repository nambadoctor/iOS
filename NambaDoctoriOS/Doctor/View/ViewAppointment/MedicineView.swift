//
//  MedicineView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/5/21.
//

import SwiftUI

struct MedicineView: View {
    @EnvironmentObject var medicineVM:MedicineViewModel

    var body: some View {
        VStack (alignment: .leading) {
            Text("PRESCRIPTIONS")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            
            if medicineVM.hasNoMedicineOrImage {
                Text("None")
            } else {
                HStack {
                    Image("checkmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.green)
                        .padding(.trailing)
                    
                    Text("Sent on \(Helpers.getTimeFromTimeStamp(timeStamp: medicineVM.prescription.createdDateTime))")

                    Divider()
                    
                    Spacer()
                }

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
                
                if medicineVM.imageLoader != nil {
                    HStack {
                        Spacer()
                        ImageView(imageLoader: medicineVM.imageLoader!)
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
