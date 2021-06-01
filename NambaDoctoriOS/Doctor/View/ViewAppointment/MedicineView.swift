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
                    .modifier(DetailedAppointmentViewIconModifier())
                
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
                        .foregroundColor(Color.blue)
                        .padding(.trailing)
                    
                    Text("Sent on \(Helpers.getTimeFromTimeStamp(timeStamp: medicineVM.prescription.createdDateTime))")

                    Divider()
                    
                    Spacer()
                }

                ForEach (medicineVM.prescription.medicineList, id: \.medicineID) { medicine in
                    HStack {
                        VStack (alignment: .leading, spacing: 5) {
                            Text("\(medicine.medicineName)")
                                .font(.callout)
                                .bold()
                                .foregroundColor(Color.blue)
                            
                            if !medicine._duration.Days.isEmpty {
                                Text("\(medicine._duration.Days) \(medicine._duration.Unit)")
                                    .font(.callout)
                                    .foregroundColor(Color.blue)
                            } else {
                                Text("No duration specified")
                                    .font(.callout)
                                    .foregroundColor(Color.blue)
                            }
                            
                            if !medicine.routeOfAdministration.isEmpty {
                                Text("\(medicine.routeOfAdministration)")
                                    .font(.callout)
                                    .foregroundColor(Color.blue)
                            }
                            
                            
                            if !medicine.intake.isEmpty {
                                Text("\(medicine.intake)")
                                    .font(.callout)
                                    .foregroundColor(Color.blue)
                            }
                            
                            if !medicine.timings.isEmpty {
                                Text("\(medicine.timings)")
                                    .font(.callout)
                                    .foregroundColor(Color.blue)
                            }
                            
                            if !medicine.specialInstructions.isEmpty {
                                Text("\(medicine.specialInstructions)")
                                    .font(.callout)
                                    .foregroundColor(Color.blue)
                            }
                            
                            if !medicine.notes.isEmpty {
                                Text("\(medicine.notes)")
                                    .font(.callout)
                                    .foregroundColor(Color.blue)
                            }
                        }
                        Spacer()
                        
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
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
