//
//  DoctorProfile.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/28/21.
//

import SwiftUI

struct DoctorProfile: View {
    @EnvironmentObject var doctorViewModel:DoctorViewModel
    @State private var wakeUp = Date()
    
    var body: some View {
        
        if self.doctorViewModel.showEdit {
            LargeButton(title: "Save Changes") {
                self.doctorViewModel.showEdit.toggle()
                self.doctorViewModel.commitEdits()
            }
            .frame(height: 50)
        }
        
        ScrollView {
            VStack (alignment: .leading) {

                if doctorViewModel.showEdit {
                    EditableDoctorProfile(editDoctorVM: doctorViewModel.editServiceProvider, doctor: $doctorViewModel.ServiceProvider)
                } else {
                    doctorInfoHeader
                    Divider()
                    appointmentInfo
                    Divider()
                }
                
                
                DoctorAvailabilityView(availabilityVM: doctorViewModel.availabilityVM)

            }.padding()
        }
    }

    var appointmentInfo : some View {
        VStack (alignment: .leading, spacing: 10) {
            HStack {Spacer()}
            
            VStack (alignment: .leading, spacing: 3) {
                Text("Consultation Fee:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text("₹\((doctorViewModel.ServiceProvider.serviceFee ?? 0).clean)")
            }
            
//            VStack (alignment: .leading, spacing: 3) {
//                Text("Followup Service Fee:")
//                    .font(.footnote)
//                    .bold()
//                    .foregroundColor(.gray)
//                Text("₹\((doctorViewModel.doctor.followUpServiceFee ?? 0).clean)")
//            }

            VStack (alignment: .leading, spacing: 3) {
                Text("Appointment Duration:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text("\(doctorViewModel.ServiceProvider.appointmentDuration ?? 0) minutes")
            }
            
//            VStack (alignment: .leading, spacing: 3) {
//                Text("Time Between Appointments:")
//                    .font(.footnote)
//                    .bold()
//                    .foregroundColor(.gray)
//                Text("\(doctorViewModel.doctor.intervalBetweenAppointment ?? 0) minutes")
//            }

        }.padding(.horizontal)
    }
    
    var doctorInfoHeader : some View {
        VStack {
            HStack {
                ImageView(imageLoader: doctorViewModel.imageLoader!)
                
                VStack (alignment: .leading, spacing: 10) {
                    VStack (alignment: .leading, spacing: 3) {
                        Text("Name:")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.gray)
                        Text("\(doctorViewModel.ServiceProvider.firstName ?? "") \(doctorViewModel.ServiceProvider.lastName ?? "")")
                    }
                    
                    VStack (alignment: .leading, spacing: 3) {
                        Text("Registration Number:")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.gray)
                        Text("\(doctorViewModel.ServiceProvider.registrationNumber ?? "")")
                    }
                    
                    VStack (alignment: .leading, spacing: 3) {
                        Text("Email:")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.gray)
                        Text("\(doctorViewModel.ServiceProvider.emailAddress ?? "")")
                    }
                }.padding()
            }
            
            Button(action: {
                CommonDefaultModifiers.showLoader(incomingLoadingText: "Generating Link")
                CreateDynamicLink().makeLink(doctorId: self.doctorViewModel.ServiceProvider.serviceProviderID, doctorName: self.doctorViewModel.serviceProviderName, profilePicURL: self.doctorViewModel.ServiceProvider.profilePictureURL ?? "") { url in
                    CommonDefaultModifiers.hideLoader()
                    shareSheet(url: url)
                }
            }, label: {
                HStack {
                    Text("Share profile with others")
                        .fixedSize(horizontal: false, vertical: true)
                    Image("square.and.arrow.up.on.square")
                        .scaleEffect(1)
                }
            })
            .padding()
        }
    }
}
