//
//  NonActionableCustomerServiceProviderViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/30/21.
//

import Foundation

class NonActionableCustomerServiceProviderViewModel : ObservableObject {
    var serviceProvider:CustomerServiceProviderProfile
    @Published var imageLoader:ImageLoader? = nil
    @Published var showDetailedProfileSheet:Bool = false
    
    init(serviceProvider:CustomerServiceProviderProfile) {
        self.serviceProvider = serviceProvider
        
        if !serviceProvider.profilePictureURL.isEmpty {
            self.imageLoader = ImageLoader(urlString: serviceProvider.profilePictureURL, { _ in })
        } else {
            self.imageLoader = ImageLoader(urlString: "https://wgsi.utoronto.ca/wp-content/uploads/2020/12/blank-profile-picture-png.png") {_ in}
        }
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
