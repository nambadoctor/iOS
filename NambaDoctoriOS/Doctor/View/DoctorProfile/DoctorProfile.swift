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
        
        ScrollView {
            VStack (alignment: .leading) {
                title
                
                Button(action: {
                    CommonDefaultModifiers.showLoader(incomingLoadingText: "Generating Link")
                    CreateDynamicLink().makeLink(doctorId: self.doctorViewModel.doctor.serviceProviderID, doctorName: self.doctorViewModel.serviceProviderName, profilePicURL: self.doctorViewModel.doctor.profilePictureURL ?? "") { url in
                        CommonDefaultModifiers.hideLoader()
                        shareSheet(url: url)
                    }
                }, label: {
                    HStack {
                        Text("Share Profile")
                            .fixedSize(horizontal: false, vertical: true)
                        Image("square.and.arrow.up.on.square")
                            .scaleEffect(1)
                    }
                })
                .padding()

                if doctorViewModel.showEdit {
                    EditableDoctorProfile(editDoctorVM: doctorViewModel.editDoctorVM, doctor: $doctorViewModel.doctor)
                } else {
                    doctorInfoHeader
                    Divider()
                    appointmentInfo
                    Divider()
                }
                
                DoctorAvailabilityView(availabilityVM: doctorViewModel.availabilityVM)

                //will have edit option in future
                Group {
                    phoneNumbers
                    Divider()
                    addresses
                    Divider()
                }
    
                //non editable | need to contact nambadoctor team to edit
                Group {
                    workExperience
                    Divider()
                    education
                }
            }.padding()
        }
    }
    
    var title : some View {
        HStack {
            Text("My Profile")
                .font(.title)
                .padding(.trailing)
            
            if !self.doctorViewModel.showEdit {
                Button(action: {
                    self.doctorViewModel.showEdit.toggle()
                }, label: {
                    Image("pencil")
                        .scaleEffect(1.5)
                })
                .padding()
            }
            
            Spacer()
            
            if self.doctorViewModel.showEdit {
                LargeButton(title: "Save Changes") {
                    self.doctorViewModel.showEdit.toggle()
                    self.doctorViewModel.commitEdits()
                }
                .frame(height: 50)
            }
        }.padding()
    }

    var education : some View {
        VStack (alignment: .leading) {
            Text("Education:")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            if doctorViewModel.doctor.educations != nil {
                ForEach(doctorViewModel.doctor.educations!, id: \.educationID) { education in
                    HStack {
                        VStack (alignment: .leading, spacing: 5) {
                            Text("\(education.course)")
                                .font(.callout)
                                .bold()
                                .foregroundColor(Color.blue)
                        }.padding()
                        Spacer()
                    }
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(7)
                }
            } else {
                HStack {
                    Spacer()
                    Text("No Educations On Record")
                    Spacer()
                }
            }
        }.padding()
    }
    
    var workExperience : some View {
        VStack (alignment: .leading) {
            Text("Work Experience:")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            if doctorViewModel.doctor.experiences != nil {
                ForEach(doctorViewModel.doctor.experiences!, id: \.workExperienceID) { experience in
                    HStack {
                        VStack (alignment: .leading, spacing: 5) {
                            Text("\(experience.organization)")
                                .font(.callout)
                                .bold()
                                .foregroundColor(Color.blue)
                            
                            Text("\(String(experience.startDate)) - \(String(experience.endDate))")
                                .font(.callout)
                                .foregroundColor(Color.blue)
                        }.padding()
                        Spacer()
                    }
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(7)
                }
            } else {
                HStack {
                    Spacer()
                    Text("No Work Experiences On Record")
                    Spacer()
                }
            }
        }.padding()
    }
    
    var addresses : some View {
        VStack (alignment: .leading) {
            Text("Addresses:")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            
            if doctorViewModel.doctor.addresses != nil {
                ForEach(doctorViewModel.doctor.addresses!, id: \.addressID) { address in
                    HStack {
                        VStack (alignment: .leading, spacing: 5) {
                            Text("\(address.streetAddress), \(address.state), \(address.country)")
                                .font(.callout)
                                .bold()
                                .foregroundColor(Color.blue)
                            
                            Text("\(address.type)")
                                .font(.callout)
                                .foregroundColor(Color.blue)
                        }.padding()
                        Spacer()
                    }
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(7)
                }
            } else {
                HStack {
                    Spacer()
                    Text("No Work Experiences On Record")
                    Spacer()
                }
            }
        }.padding()
    }
    
    var phoneNumbers : some View {
        VStack (alignment: .leading) {
            Text("Phone Numbers:")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            if doctorViewModel.doctor.phoneNumbers != nil {
                ForEach(doctorViewModel.doctor.phoneNumbers!, id: \.phoneNumberID) { phoneNumber in
                    HStack {
                        VStack (alignment: .leading, spacing: 5) {
                            Text("\(phoneNumber.countryCode)\(phoneNumber.number)")
                                .font(.callout)
                                .bold()
                                .foregroundColor(Color.blue)
                            
                            Text("\(phoneNumber.type)")
                                .font(.callout)
                                .foregroundColor(Color.blue)
                        }.padding()
                        Spacer()
                    }
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(7)
                }
            } else {
                HStack {
                    Spacer()
                    Text("No Phone Numbers On Record")
                    Spacer()
                }
            }
        }.padding()
    }
    
    var appointmentInfo : some View {
        VStack (alignment: .leading, spacing: 10) {
            HStack {Spacer()}
            
            VStack (alignment: .leading, spacing: 3) {
                Text("Regular Service Fee:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text("₹\((doctorViewModel.doctor.serviceFee ?? 0).clean)")
            }
            
            VStack (alignment: .leading, spacing: 3) {
                Text("Followup Service Fee:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text("₹\((doctorViewModel.doctor.followUpServiceFee ?? 0).clean)")
            }

            VStack (alignment: .leading, spacing: 3) {
                Text("Appointment Duration:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text("\(doctorViewModel.doctor.appointmentDuration ?? 0) minutes")
            }
            
            VStack (alignment: .leading, spacing: 3) {
                Text("Time Between Appointments:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text("\(doctorViewModel.doctor.intervalBetweenAppointment ?? 0) minutes")
            }
        }.padding(.horizontal)
    }
    
    var doctorInfoHeader : some View {
        HStack {
            ImageView(imageLoader: doctorViewModel.imageLoader!)
            
            VStack (alignment: .leading, spacing: 10) {
                VStack (alignment: .leading, spacing: 3) {
                    Text("Name:")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    Text("\(doctorViewModel.doctor.firstName ?? "") \(doctorViewModel.doctor.lastName ?? "")")
                }
                
                VStack (alignment: .leading, spacing: 3) {
                    Text("Registration Number:")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    Text("\(doctorViewModel.doctor.registrationNumber ?? "")")
                }
                
                VStack (alignment: .leading, spacing: 3) {
                    Text("Email:")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    Text("\(doctorViewModel.doctor.emailAddress ?? "")")
                }
            }.padding()
        }
    }
}
