//
//  DoctorProfile.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/28/21.
//

import SwiftUI

struct DoctorProfile: View {
    var doctor:ServiceProviderProfile = sampleServiceProvider
    @State var editProfile:Bool = false
    
    var body: some View {
        ScrollView {
            
            if editProfile {
            } else {
            }
            
            doctorInfoHeader
            Divider()
            appointmentInfo
            Divider()
            phoneNumbers
            Divider()
            addresses
            Divider()
            
            //non editable
            Group {
                workExperience
                Divider()
                education
            }
        }.padding()
    }
    
    var education : some View {
        VStack (alignment: .leading) {
            Text("Education:")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            ForEach(doctor.educations, id: \.educationID) { education in
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        Text("\(education.course)")
                            .font(.callout)
                            .bold()
                            .foregroundColor(Color.green)
                        
                        Text("\(education.college), \(education.country) - \(String(education.year))")
                            .font(.callout)
                            .foregroundColor(Color.green)
                    }.padding()
                    Spacer()
                }
                .background(Color.green.opacity(0.3))
                .cornerRadius(7)
            }
        }.padding()
    }
    
    var workExperience : some View {
        VStack (alignment: .leading) {
            Text("Work Experience:")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            ForEach(doctor.experiences, id: \.workExperienceID) { experience in
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        Text("\(experience.organization)")
                            .font(.callout)
                            .bold()
                            .foregroundColor(Color.green)
                        
                        Text("\(String(experience.startDate)) - \(String(experience.endDate))")
                            .font(.callout)
                            .foregroundColor(Color.green)
                    }.padding()
                    Spacer()
                }
                .background(Color.green.opacity(0.3))
                .cornerRadius(7)
            }
        }.padding()
    }
    
    var addresses : some View {
        VStack (alignment: .leading) {
            Text("Addresses:")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            ForEach(doctor.addresses, id: \.addressID) { address in
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        Text("\(address.streetAddress), \(address.state), \(address.country)")
                            .font(.callout)
                            .bold()
                            .foregroundColor(Color.green)
                        
                        Text("\(address.type)")
                            .font(.callout)
                            .foregroundColor(Color.green)
                    }.padding()
                    Spacer()
                }
                .background(Color.green.opacity(0.3))
                .cornerRadius(7)
            }
        }.padding()
    }
    
    var phoneNumbers : some View {
        VStack (alignment: .leading) {
            Text("Phone Numbers:")
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
            ForEach(doctor.phoneNumbers, id: \.phoneNumberID) { phoneNumber in
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        Text("\(phoneNumber.countryCode)\(phoneNumber.number)")
                            .font(.callout)
                            .bold()
                            .foregroundColor(Color.green)
                        
                        Text("\(phoneNumber.type)")
                            .font(.callout)
                            .foregroundColor(Color.green)
                    }.padding()
                    Spacer()
                }
                .background(Color.green.opacity(0.3))
                .cornerRadius(7)
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
                Text("\(doctor.serviceFee.clean)₹")
            }
            
            VStack (alignment: .leading, spacing: 3) {
                Text("Followup Service Fee:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text("\(doctor.followUpServiceFee.clean)₹")
            }
            
            VStack (alignment: .leading, spacing: 3) {
                Text("Appointment Duration:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text("\(doctor.appointmentDuration) minutes")
            }
            
            VStack (alignment: .leading, spacing: 3) {
                Text("Time Between Appointments:")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
                Text("\(doctor.intervalBetweenAppointment) minutes")
            }
        }.padding(.horizontal)
    }
    
    var doctorInfoHeader : some View {
        HStack {
            ImageView(withURL: doctor.profilePictureURL)
            
            VStack (alignment: .leading, spacing: 10) {
                VStack (alignment: .leading, spacing: 3) {
                    Text("Name:")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    Text("\(doctor.firstName) \(doctor.lastName)")
                }
                
                VStack (alignment: .leading, spacing: 3) {
                    Text("Registration Number:")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    Text("\(doctor.registrationNumber)")
                }
                
                VStack (alignment: .leading, spacing: 3) {
                    Text("Email:")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    Text("\(doctor.emailAddress)")
                }
            }.padding()
        }
    }
}
struct DoctorProfile_Previews: PreviewProvider {
    static var previews: some View {
        DoctorProfile()
    }
}
