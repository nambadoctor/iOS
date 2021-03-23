//
//  DetailedUpcomingAppointmentView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/03/21.
//

import SwiftUI

struct DetailedUpcomingAppointmentView: View {
    var appointment:ServiceProviderAppointment
    @State var allergies:String = ""
    @State var medicalHistory:String = ""
    var body: some View {
        ScrollView (.vertical) {
            VStack {
                header
                Divider().background(Color.blue.opacity(0.4))
                actionButtons
            }
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
            
            VStack (alignment: .leading) {
                AllergyAndMedHistory
                
                Text("Doctor's Section")
                    .font(.title)
                    .bold()
                    .padding([.top, .bottom])
                ClinicalSummary
                Investigations
                Prescriptions
            }
            .padding(.top)
            .padding(.leading, 2)
            
            Spacer()
            
        }
        .padding([.leading, .trailing])
    }
    
    var header : some View {
        VStack (alignment: .leading) {
            Text(Helpers.getTimeFromTimeStamp(timeStamp: appointment.scheduledAppointmentStartTime))
                .foregroundColor(.blue)
                .bold()
            HStack (alignment: .top) {
                Image("person.crop.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                VStack (alignment: .leading, spacing: 5) {
                    Text(appointment.customerName)
                    Text("22, Male")
                    
                    Text("Fee: Rs. 550")
                }
                Spacer()
            }
        }.padding()
    }
    
    var actionButtons : some View {
        HStack {
            
            Button(action: {
                
            }, label: {
                VStack (alignment: .center) {
                    Image("xmark.circle")
                        .scaleEffect(1.5)
                }
            })
            Spacer()
            Button(action: {
                
            }, label: {
                VStack (alignment: .center) {
                    Image("phone")
                        .scaleEffect(1.5)
                }
            })
            Spacer()
            Button(action: {
                
            }, label: {
                VStack (alignment: .center) {
                    Image(systemName: "video")
                        .scaleEffect(1.5)
                }
            })
        }
        .padding([.leading, .trailing], 50)
        .padding(.top, 10)
        .padding(.bottom, 18)
    }
    
    var AllergyAndMedHistory : some View {
        VStack (alignment: .leading) {
            Text("ALLERGIES:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            CustomTextField(
                placeholder: Text("insulin, grass, etc...").foregroundColor(.black),
                text: $allergies
            )
            Divider().padding(.bottom)
            
            Text("HISTORY:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            CustomTextField(
                placeholder: Text("patient's medical history").foregroundColor(.black),
                text: $medicalHistory
            )
            Divider()
        }
    }
    
    var ClinicalSummary : some View {
        VStack {
            VStack (alignment: .leading) {
                Text("EXAMINATION:")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                
                TextField("type here...", text: $allergies)
                Divider().padding(.bottom)
                
                Text("DIAGNOSIS:")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                TextField("type here...", text: $allergies)
                Divider().padding(.bottom)
                
                Text("ADVICE FOR PATIENT:")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                TextField("type here...", text: $allergies)
                Divider()
            }
        }.padding(.bottom)
    }
    
    var Investigations : some View {
        VStack (alignment: .leading) {
            Text("INVESTIGATIONS:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            HStack (alignment: .top) {
                VStack {
                    TextField("type here...", text: $allergies)
                    Divider()
                    
                    HStack {
                        Text("This is a sample investigation after its been entered into here")
                            .font(.callout)
                            .foregroundColor(Color.green)
                            .padding()
                        Spacer()
                    }
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(7)
                }.padding(.trailing, 5)
                
                Button(action: {
                    
                }, label: {
                    Image("plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                })
            }
        }.padding(.bottom)
    }
    
    var Prescriptions : some View {
        VStack (alignment: .leading) {
            Text("PRESCRIPTION:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            ScrollView (.horizontal, showsIndicators: false) {
                 HStack {
                     Image("photo.fill")
                        .resizable()
                        .frame(width: 80)
                        .foregroundColor(.gray)
                    
                    Image("photo.fill")
                       .resizable()
                       .frame(width: 80)
                       .foregroundColor(.gray)
                    
                    Image("photo.fill")
                       .resizable()
                       .frame(width: 80)
                       .foregroundColor(.gray)
                 }
            }.frame(height: 100)
            
            HStack {
                
                LargeButton(title: "Enter Manually",
                            backgroundColor: Color.white,
                            foregroundColor: Color.yellow) {
                    print("Hello World")
                }
                
                LargeButton(title: "Upload Image",
                            backgroundColor: Color.green) {
                    print("Hello World")
                }
            }
        }
    }
}

struct DetailedUpcomingAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedUpcomingAppointmentView(appointment: ServiceProviderAppointment(appointmentID: "", serviceRequestID: "", parentAppointmentID: "", customerID: "", serviceProviderID: "", requestedBy: "", serviceProviderName: "Dr. Rajesh", customerName: "Surya Manivannan", isBlockedByServiceProvider: false, status: "confirmed", serviceFee: 500, followUpDays: 0, isPaid: false, scheduledAppointmentStartTime: Date().millisecondsSince1970, scheduledAppointmentEndTime: Date().millisecondsSince1970 + 500, actualAppointmentStartTime: 0, actualAppointmentEndTime: 0, createdDateTime: Date().millisecondsSince1970, lastModifiedDate: 0, noOfReports: 2))
    }
}
