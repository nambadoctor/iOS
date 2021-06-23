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
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading) {
                HStack {
                    Spacer()

                    VStack (alignment: .center) {
                        ImageView(imageLoader: doctorProfileVM.imageLoaderVM)
                            .clipShape(Circle())
                            .padding(.top, 5)

                        Text(doctorProfileVM.name)
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 2)
                        
                        if !doctorProfileVM.serviceProviderProfile.additionalInfo.Designation.isEmpty {
                            Text(doctorProfileVM.serviceProviderProfile.additionalInfo.Designation[0])
                               .font(.headline)
                        }

                        Button(action: {
                            self.doctorProfileVM.generateLinkCallBack()
                        }, label: {
                            HStack {
                                Text("Refer doctor to a friend")
                                Image("square.and.arrow.up.on.square")
                            }
                        })
                        .padding()
                    }

                    Spacer()
                }
                
                HStack (alignment: .center) {
                    VStack (alignment: .center) {
                        Image("checkmark.seal.fill")
                            .scaleEffect(2)
                            .padding(.bottom, 10)
                            .foregroundColor(Color.blue)
                        Text("\(self.doctorProfileVM.getAllWorkExperience) Years")
                            .font(.system(size: 18))
                        Text("Experience")
                            .font(.system(size: 15))
                    }
                    .modifier(SmallCardModifier())
                    
                    Spacer()
                    
                    VStack (alignment: .center) {
                        Image("rosette")
                            .scaleEffect(2)
                            .padding(.bottom, 10)
                            .foregroundColor(Color.blue)
                        Text("\(self.doctorProfileVM.serviceProviderProfile.additionalInfo.Certifications.count) Awards")
                            .font(.system(size: 18))
                        Text("Recieved")
                            .font(.system(size: 15))
                    }
                    .modifier(SmallCardModifier())
                    
                    Spacer()
                    
                    VStack (alignment: .center) {
                        Image("globe")
                            .scaleEffect(2)
                            .padding(.bottom, 10)
                            .foregroundColor(Color.blue)
                        Text("\(self.doctorProfileVM.serviceProviderProfile.languages.count) Languages")
                            .font(.system(size: 18))
                        Text("Known")
                            .font(.system(size: 15))
                    }
                    .modifier(SmallCardModifier())
                }
                .padding(.horizontal, 1)
                .padding(.bottom, 8)
                
                if !self.doctorProfileVM.serviceProviderProfile.additionalInfo.Description.isEmpty {
                    ExpandableTextView(self.doctorProfileVM.serviceProviderProfile.additionalInfo.Description, lineLimit: 3)
                        .padding(.top, 8)
                }

                VStack (alignment: .leading, spacing: 15) {
                    
                    if !self.doctorProfileVM.educations.isEmpty {
                        VStack (alignment: .leading) {
                            HStack {
                                Image("graduationcap")
                                    .modifier(DetailedAppointmentViewIconModifier())
                                Text("DEGREES")
                                    .modifier(FootnoteTitleModifier())
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            
                            ForEach(self.doctorProfileVM.educations, id: \.self) { text in
                                Text("•\t\(text)")
                            }
                        }.modifier(CardModifierControlledPadding(horizontalPadding: 1))
                    }
                    
                    if !doctorProfileVM.serviceProviderProfile.additionalInfo.Specialties.isEmpty {
                        VStack (alignment: .leading) {
                            HStack {
                                Image("stethoscope")
                                    .modifier(DetailedAppointmentViewIconModifier())
                                Text("SPECIALTIES")
                                    .modifier(FootnoteTitleModifier())
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            
                            FlowLayout(mode: .scrollable,
                                                       binding: .constant(5),
                                                       items: doctorProfileVM.serviceProviderProfile.additionalInfo.Specialties) {
                                DisplayChip(text: $0)
                            }
                        }.modifier(CardModifierControlledPadding(horizontalPadding: 1))
                    }
                    
                    if !doctorProfileVM.serviceProviderProfile.additionalInfo.Procedures.isEmpty {
                        VStack (alignment: .leading) {
                            HStack {
                                Image("text.magnifyingglass")
                                    .modifier(DetailedAppointmentViewIconModifier())
                                Text("PROCEDURES")
                                    .modifier(FootnoteTitleModifier())
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            
                            FlowLayout(mode: .scrollable,
                                                       binding: .constant(5),
                                                       items: doctorProfileVM.serviceProviderProfile.additionalInfo.Procedures) {
                                DisplayChip(text: $0)
                            }
                        }.modifier(CardModifierControlledPadding(horizontalPadding: 1))
                    }

                    if !doctorProfileVM.serviceProviderProfile.experiences.isEmpty {
                        VStack (alignment: .leading) {
                            HStack {
                                Image("briefcase.fill")
                                    .modifier(DetailedAppointmentViewIconModifier())
                                Text("CURRENTLY WORKING")
                                    .modifier(FootnoteTitleModifier())
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            
                            Text(doctorProfileVM.serviceProviderProfile.experiences[0].organization)
                        }.modifier(CardModifierControlledPadding(horizontalPadding: 1))
                    }

                    if !self.doctorProfileVM.serviceProviderProfile.additionalInfo.ClubMemberships.isEmpty {
                        VStack (alignment: .leading) {
                            HStack {
                                Image("person.3.fill")
                                    .modifier(DetailedAppointmentViewIconModifier())
                                Text("SOCIETIES")
                                    .modifier(FootnoteTitleModifier())
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            
                            ForEach(self.doctorProfileVM.serviceProviderProfile.additionalInfo.ClubMemberships, id: \.self) { text in
                                Text("•\t\(text)")
                            }
                        }.modifier(CardModifierControlledPadding(horizontalPadding: 1))
                    }

                    if !self.doctorProfileVM.serviceProviderProfile.additionalInfo.Certifications.isEmpty {
                        VStack (alignment: .leading) {
                            HStack {
                                Image("checkmark.seal.fill")
                                    .modifier(DetailedAppointmentViewIconModifier())
                                Text("CERTIFICATES AND AWARDS")
                                    .modifier(FootnoteTitleModifier())
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            
                            ForEach(self.doctorProfileVM.serviceProviderProfile.additionalInfo.Certifications, id: \.self) { text in
                                Text("•\t\(text)")
                            }
                        }.modifier(CardModifierControlledPadding(horizontalPadding: 1))
                    }

                    if !self.doctorProfileVM.serviceProviderProfile.additionalInfo.Published.isEmpty {
                        VStack (alignment: .leading) {
                            HStack {
                                Image("newspaper")
                                    .modifier(DetailedAppointmentViewIconModifier())
                                Text("JOURNALS PUBLISHED")
                                    .modifier(FootnoteTitleModifier())
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            
                            ForEach(self.doctorProfileVM.serviceProviderProfile.additionalInfo.Published, id: \.self) { text in
                                Text("•\t\(text)")
                            }
                        }.modifier(CardModifierControlledPadding(horizontalPadding: 1))
                    }

                    if !self.doctorProfileVM.serviceProviderProfile.additionalInfo.Links.isEmpty {
                        VStack (alignment: .leading) {
                            HStack {
                                Image(systemName: "link.icloud")
                                    .modifier(DetailedAppointmentViewIconModifier())
                                Text("WEBSITES")
                                    .modifier(FootnoteTitleModifier())
                                Spacer()
                            }
                            .padding(.bottom, 5)
                            
                            ForEach(self.doctorProfileVM.serviceProviderProfile.additionalInfo.Links, id: \.self) { text in
                                Text("•\t\(text)")
                            }
                        }.modifier(CardModifierControlledPadding(horizontalPadding: 1))
                    }

                    if !self.doctorProfileVM.serviceProviderProfile.languages.isEmpty {
                        VStack (alignment: .leading) {
                            HStack {
                                Image("globe")
                                    .modifier(DetailedAppointmentViewIconModifier())
                                Text("LANGUAGES")
                                    .modifier(FootnoteTitleModifier())
                                Spacer()
                            }
                            .padding(.bottom, 5)

                            FlowLayout(mode: .scrollable,
                                                       binding: .constant(5),
                                                       items: self.doctorProfileVM.serviceProviderProfile.languages) {
                                DisplayChip(text: $0)
                            }
                        }.modifier(CardModifierControlledPadding(horizontalPadding: 1))
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
