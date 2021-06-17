//
//  EditableDoctorProfile.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/28/21.
//

import SwiftUI

struct EditableDoctorProfilePic : View{
    @ObservedObject var imagePickerViewModel:ImagePickerViewModel
    @ObservedObject var imageLoader:ImageLoader
    
    init(doctorProfileURL:String, imagePickerViewModel:ImagePickerViewModel) {
        self.imagePickerViewModel = imagePickerViewModel
        self.imageLoader = ImageLoader(urlString: doctorProfileURL) { success in }
    }
    
    var body : some View {
        VStack (spacing: 0) {
            if imagePickerViewModel.image != nil {
                Image(uiImage: imagePickerViewModel.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:120, height:160)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            } else {
                ImageView(imageLoader: imageLoader)
            }

            Button(action: {
                imagePickerViewModel.showActionSheet()
            }, label: {
                Text("edit")
            })
        }.modifier(ImagePickerModifier(imagePickerVM: imagePickerViewModel))

    }
}

struct EditableDoctorProfile: View {
    @ObservedObject var editDoctorVM:EditServiceProviderViewModel
    @Binding var doctor:ServiceProviderProfile

    var body: some View {
        VStack {
            editableDoctorInfoHeader
            Divider()
            editableAppointmentInfo
            Divider()
        }.onAppear() {
            //map values
            editDoctorVM.AppointmentDuration = String(doctor.appointmentDuration ?? 0)
            editDoctorVM.FollowUpServiceFee = String((doctor.followUpServiceFee ?? 0).clean)
            editDoctorVM.TimeIntervalBetweenAppointments = String(doctor.intervalBetweenAppointment ?? 0)
            editDoctorVM.ServiceFee = String((doctor.serviceFee ?? 0).clean)
        }
    }

    var editableDoctorInfoHeader : some View {
        HStack {
            
            if doctor.profilePictureURL != nil {
                EditableDoctorProfilePic(doctorProfileURL: doctor.profilePictureURL!, imagePickerViewModel: editDoctorVM.imagePickerViewModel)
            }

            VStack (alignment: .leading, spacing: 10) {
                VStack (alignment: .leading, spacing: 3) {
                    Text("Name:")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    Text("\(doctor.firstName != nil ? doctor.firstName! : "") \(doctor.lastName != nil ? doctor.lastName! : "")")
                }
                
                VStack (alignment: .leading, spacing: 3) {
                    Text("Registration Number:")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    if doctor.registrationNumber != nil {
                        Text(doctor.registrationNumber ?? "")
                    }
                }
                
                VStack (alignment: .leading, spacing: 3) {
                    Text("Email:")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    if doctor.emailAddress != nil {
                        Text(doctor.emailAddress!)
                    }
                }
            }.padding()
        }
    }
    
    var editableAppointmentInfo : some View {
        VStack (alignment: .leading, spacing: 10) {
            HStack {Spacer()}
            
            VStack (alignment: .leading, spacing: 3) {
                Text("Regular Service Fee:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                ExpandingTextView(text: $editDoctorVM.ServiceFee)
            }
            
            VStack (alignment: .leading, spacing: 3) {
                Text("Followup Service Fee:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                ExpandingTextView(text: $editDoctorVM.FollowUpServiceFee)
            }
             
            VStack (alignment: .leading, spacing: 3) {
                Text("Appointment Duration:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                ExpandingTextView(text: $editDoctorVM.AppointmentDuration)
            }
            
            VStack (alignment: .leading, spacing: 3) {
                Text("Time Between Appointments:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                ExpandingTextView(text: $editDoctorVM.TimeIntervalBetweenAppointments)
            }
        }.padding(.horizontal)
    }
}
