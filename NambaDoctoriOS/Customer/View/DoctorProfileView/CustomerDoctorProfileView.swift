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

                        Text(doctorProfileVM.name)
                            .font(.title2)
                            .padding(.bottom, 5)
                        
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
                
                HStack {
                    VStack (alignment: .center) {
                        Image("checkmark.seal.fill")
                            .scaleEffect(2)
                            .padding(5)
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
                            .padding(5)
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
                            .padding(5)
                            .foregroundColor(Color.blue)
                        Text("\(self.doctorProfileVM.serviceProviderProfile.languages.count) Languages")
                            .font(.system(size: 18))
                        Text("Known")
                            .font(.system(size: 15))
                    }
                    .modifier(SmallCardModifier())
                }.padding(.horizontal, 1)
                
                ExpandableTextView(self.doctorProfileVM.serviceProviderProfile.additionalInfo.Description, lineLimit: 3)
                    .padding([.top, .bottom], 8)
                
                VStack (alignment: .leading, spacing: 15) {
                    VStack (alignment: .leading) {
                        HStack {
                            Image("graduationcap")
                                .modifier(DetailedAppointmentViewIconModifier())
                            Text("Degrees")
                            Spacer()
                        }
                        .padding(.bottom, 5)
                        
                        ForEach(self.doctorProfileVM.educations, id: \.self) { text in
                            Text("•\t\(text)")
                        }
                    }.modifier(CardModifierControlledPadding(horizontalPadding: 1))
                    
                    VStack (alignment: .leading) {
                        HStack {
                            Image("stethoscope")
                                .modifier(DetailedAppointmentViewIconModifier())
                            Text("Specialties")
                            Spacer()
                        }
                        .padding(.bottom, 5)
                        
                        FlowLayout(mode: .scrollable,
                                                   binding: .constant(5),
                                                   items: doctorProfileVM.serviceProviderProfile.additionalInfo.Specialties) {
                            DisplayChip(text: $0)
                        }
                    }.modifier(CardModifierControlledPadding(horizontalPadding: 1))
                    
                    VStack (alignment: .leading) {
                        HStack {
                            Image("text.magnifyingglass")
                                .modifier(DetailedAppointmentViewIconModifier())
                            Text("Procedures")
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
            }
        }
        .padding(.horizontal)
    }
}
