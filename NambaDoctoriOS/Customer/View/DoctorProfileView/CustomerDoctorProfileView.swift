//
//  DoctorProfileView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/27/21.
//

import SwiftUI

struct CustomerDoctorProfileView: View {
    @ObservedObject var doctorProfileVM:CustomerDoctorProfileViewModel
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                
                Text("Doctor Profile")
                    .font(.title)
                    .bold()
                    .padding()

                HStack {
                    Spacer()
                    
                    ImageView(imageLoader: doctorProfileVM.imageLoaderVM)
                    
                    Button(action: {
                        CommonDefaultModifiers.showLoader(incomingLoadingText: "Generating Link")
                        CreateDynamicLink().makeLink(doctorId: self.doctorProfileVM.serviceProviderProfile.serviceProviderID, doctorName: doctorProfileVM.name, profilePicURL: doctorProfileVM.serviceProviderProfile.profilePictureURL) { url in
                            CommonDefaultModifiers.hideLoader()
                            shareSheet(url: url)
                        }
                    }, label: {
                        Image("square.and.arrow.up.on.square")
                            .scaleEffect(1.5)
                    })
                    .padding()
                    
                    Spacer()
                }
                
                VStack (alignment: .leading, spacing: 10) {
                    VStack (alignment: .leading, spacing: 3) {
                        Text("EMAIL")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.gray)
                        Text(self.doctorProfileVM.name)
                        HStack{Spacer()}
                    }
                    
                    VStack (alignment: .leading, spacing: 3) {
                        Text("REGISTRATION NUMBER")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.gray)
                        Text(doctorProfileVM.serviceProviderProfile.registrationNumber)
                    }

                    VStack (alignment: .leading, spacing: 3) {
                        Text("EMAIL")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.gray)
                        Text(doctorProfileVM.serviceProviderProfile.emailAddress)
                        HStack{Spacer()}
                    }
                }.modifier(CardModifier())
                
                VStack (alignment: .leading) {
                    Text("EDUCATION")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    HStack{Spacer()}
                    TagCloudViewForDisplayOnly(tags: self.doctorProfileVM.educations)
                }
                .modifier(CardModifier())
                
                VStack (alignment: .leading) {
                    Text("WORK EXPERIENCE")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    HStack{Spacer()}
                    TagCloudViewForDisplayOnly(tags: self.doctorProfileVM.educations)
                    
                }
                .modifier(CardModifier())
                
                VStack (alignment: .leading) {
                    Text("SPECIALTIES")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    HStack{Spacer()}
                    TagCloudViewForDisplayOnly(tags: self.doctorProfileVM.specialties)
                }
                .modifier(CardModifier())
                
                VStack (alignment: .leading) {
                    Text("LANGUAGES")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                    HStack{Spacer()}
                    TagCloudViewForDisplayOnly(tags: self.doctorProfileVM.serviceProviderProfile.languages)
                }
                .modifier(CardModifier())
            }
        }
    }
}
