//
//  TransferAppointmentDoctorCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/26/21.
//

import SwiftUI

struct TransferAppointmentDoctorCard : View {
    
    @ObservedObject var transferAppointmentCardVM:TransferAppointmentDoctorCardViewModel
    @State var doctorSelected:Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                
                ImageViewWithNoSheet(url: self.transferAppointmentCardVM.serviceProvider.profilePictureURL, height: 80, width: 80)
                    .clipShape(Circle())
                
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                    }
                    Text(transferAppointmentCardVM.serviceProviderName)
                        .font(.system(size: 17))
                        .bold()
                    
                    if !transferAppointmentCardVM.serviceProvider.additionalInfo.Designation.isEmpty {
                        Text(transferAppointmentCardVM.serviceProvider.additionalInfo.Designation[0])
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                    } else {
                        if !transferAppointmentCardVM.serviceProvider.additionalInfo.Specialties.isEmpty {
                            Text(transferAppointmentCardVM.serviceProvider.additionalInfo.Specialties[0])
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                        } else {
                            Text("")
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                        }
                    }

                    HStack (alignment: .bottom) {
                        VStack (alignment: .leading) {
                            Text(transferAppointmentCardVM.experience)
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                            
                            Text(transferAppointmentCardVM.fees)
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                            
                            Text("Consult in \(transferAppointmentCardVM.serviceProvider.languages.joined(separator: ","))")
                                .font(.system(size: 15))
                                .foregroundColor(Color.blue)
                        }

                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    self.doctorSelected = true
                                } label: {
                                    Text("Select")
                                        .padding(.horizontal)
                                        .padding(.vertical, 7)
                                        .background(Color.blue)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(5)
                                }
                            }
                        }
                    }
                    
                    if self.doctorSelected {
                        AvailabilitySelector(availabilitySelectorVM: self.transferAppointmentCardVM.availabilitySelector)
                            .onAppear() {self.transferAppointmentCardVM.availabilitySelector.retrieveAvailabilities()}
                        
                        LargeButton(title: "Confirm Transfer") {
                            guard self.transferAppointmentCardVM.availabilitySelector.selectedDate != 0, self.transferAppointmentCardVM.availabilitySelector.selectedTime != 0 else {
                                CustomerAlertHelpers().pleaseChooseTimeandDateAlert { _ in }
                                return
                            }
                            
                            self.transferAppointmentCardVM.confirmTransfer()
                            
                            ServiceProviderAppointmentService().transferAppointment(appointment: self.transferAppointmentCardVM.appointment) { transferId in
                                if transferId != nil {
                                    self.transferAppointmentCardVM.killView()
                                }
                            }
                        }
                    }
                }.padding(.leading, 3)

            }.padding()

        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.top, 5)
    }

}

class TransferAppointmentDoctorCardViewModel : ObservableObject {
    var serviceProvider:CustomerServiceProviderProfile
    var appointment:ServiceProviderAppointment
    @Published var imageLoader:ImageLoader? = nil
    @Published var showDetailedProfileSheet:Bool = false
    var killView:()->()
    
    @Published var availabilitySelector:AvailabilitySelectorViewModel
    
    init(serviceProvider:CustomerServiceProviderProfile, appointment:ServiceProviderAppointment, killView:@escaping ()->()) {
        self.serviceProvider = serviceProvider
        self.appointment = appointment
        self.killView = killView
        if !serviceProvider.profilePictureURL.isEmpty {
            self.imageLoader = ImageLoader(urlString: serviceProvider.profilePictureURL, { _ in })
        } else {
            self.imageLoader = ImageLoader(urlString: "https://wgsi.utoronto.ca/wp-content/uploads/2020/12/blank-profile-picture-png.png") {_ in}
        }
        
        self.availabilitySelector = AvailabilitySelectorViewModel(serviceProviderID: serviceProvider.serviceProviderID, slotSelected: nil, organisationId: self.appointment.organisationId, overrideAvailability: true, doctorBookingForSelf: false)
    }

    var serviceProviderName:String {
        return "\(serviceProvider.firstName) \(serviceProvider.lastName)"
    }
    
    var specialties: String {
        return serviceProvider.specialties.joined(separator: ",")
    }
    
    var experience:String {
        return "\(getServiceProviderExperience()) years exp"
    }
    
    var fees:String {
        return "Fees: ₹\(serviceProvider.serviceFee.clean)"
    }
    
    func getServiceProviderExperience () -> Int {
        var experienceInYears = 0
        for exp in serviceProvider.experiences {
            experienceInYears += yearsBetweenDate(startDate: Date(milliseconds: exp.startDate), endDate: Date(milliseconds: exp.endDate))
        }
        return experienceInYears
    }
    
    func yearsBetweenDate(startDate: Date, endDate: Date) -> Int {

        let calendar = Calendar.current

        let components = calendar.dateComponents([.year], from: startDate, to: endDate)

        return components.year!
    }
    
    func confirmTransfer () {
        self.appointment.status = "Transferred"
        
        let transfer = ServiceProviderAppointmentTransfer(AppointmentTransferId: "", TransferredBy: UserIdHelper().retrieveUserId(), TransferredTo: self.serviceProvider.serviceProviderID, TransferReason: "", TransferredTime: Date().millisecondsSince1970)

        self.appointment.AppointmentTransfer = transfer
    }
}
