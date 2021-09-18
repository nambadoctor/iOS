//
//  CustomerServiceProviderViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

class CustomerServiceProviderViewModel : ObservableObject {
    var serviceProvider:CustomerServiceProviderProfile 
    @Published var imageLoader:ImageLoader? = nil
    @Published var showDetailedProfileSheet:Bool = false
    var customerProfile:CustomerProfile
    var callBack:(CustomerServiceProviderProfile)->()
    var appointments:[CustomerAppointment]
    
    @Published var showAppointmentsForDoctor:Bool = false
    @Published var takeToDetailedAppointment:Bool = false
    @Published var selectedAppointment:CustomerAppointment? = nil
    
    init(serviceProvider:CustomerServiceProviderProfile,
         customerProfile:CustomerProfile,
         callBack:@escaping (CustomerServiceProviderProfile)->(),
         appointments:[CustomerAppointment]) {
        self.serviceProvider = serviceProvider
        self.customerProfile = customerProfile
        self.callBack = callBack
        
        if !serviceProvider.profilePictureURL.isEmpty {
            self.imageLoader = ImageLoader(urlString: serviceProvider.profilePictureURL, { _ in })
        } else {
            self.imageLoader = ImageLoader(urlString: "https://wgsi.utoronto.ca/wp-content/uploads/2020/12/blank-profile-picture-png.png") {_ in}
        }
        
        self.appointments = appointments
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
    
    func getAppointmentsWithServiceProvider () -> Int {
        var count = 0
        for appointment in appointments {
            if appointment.serviceProviderID == self.serviceProvider.serviceProviderID {
                count += 1
            }
        }

        return count
    }
    
    func yearsBetweenDate(startDate: Date, endDate: Date) -> Int {

        let calendar = Calendar.current

        let components = calendar.dateComponents([.year], from: startDate, to: endDate)

        return components.year!
    }
    
    func takeToBookDocView () {
        self.callBack(serviceProvider)
    }
    
    func getDetailedServiceProviderVM() -> CustomerDoctorProfileViewModel {
        CustomerDoctorProfileViewModel(serviceProviderProfile: self.serviceProvider, generateLinkCallBack: makeLink)
    }

    func makeLink () {
        self.showDetailedProfileSheet = false
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Generating Link")
        CreateDynamicLink().makeLink(doctorId: self.serviceProvider.serviceProviderID, doctorName: serviceProviderName, profilePicURL: serviceProvider.profilePictureURL) { url in
            CommonDefaultModifiers.hideLoader()
            shareSheet(url: url)
        }
    }
}

extension CustomerServiceProviderViewModel : CustomerSelectAppointmentDelegate {
    func selected(appointment: CustomerAppointment) {
        self.selectedAppointment = appointment
        self.takeToDetailedAppointment = true
    }
    
    func getDetailedAppointmentVM () -> CustomerDetailedAppointmentViewModel {
        return CustomerDetailedAppointmentViewModel(appointment: self.selectedAppointment!)
    }
}
