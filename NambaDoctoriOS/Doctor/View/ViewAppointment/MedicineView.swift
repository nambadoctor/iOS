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
            
            HStack (spacing: 3) {
                Image("pills")
                    .scaleEffect(0.8)
                    .foregroundColor(Color.gray)
                
                Text("PRESCRIPTION")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }
            
            if medicineVM.hasNoMedicineOrImage {
                HStack {
                    Text("None")
                    Spacer()
                }
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
                            
                            if medicine.duration != 0 {
                                Text("\(medicine.duration) days")
                                    .font(.callout)
                                    .foregroundColor(Color.green)
                            } else {
                                Text("No duration specified")
                                    .font(.callout)
                                    .foregroundColor(Color.green)
                            }
                            
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
                            
                            if !medicine.timings.isEmpty {
                                Text("\(medicine.timings)")
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
        .padding()
    }
}
