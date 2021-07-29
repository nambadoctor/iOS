//
//  ServiceProviderViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/29/21.
//

import SwiftUI

class ServiceProviderViewModel : ObservableObject {
    var serviceProvider:ServiceProviderProfile
    @Published var imageLoader:ImageLoader? = nil
    @Published var showDetailedProfileSheet:Bool = false
    var callBack:(ServiceProviderProfile)->()
    
    init(serviceProvider:ServiceProviderProfile,
         callBack:@escaping (ServiceProviderProfile)->()) {
        self.serviceProvider = serviceProvider
        self.callBack = callBack
        
        if serviceProvider.profilePictureURL != nil && serviceProvider.profilePictureURL!.isEmpty {
            self.imageLoader = ImageLoader(urlString: serviceProvider.profilePictureURL!, { _ in })
        } else {
            self.imageLoader = ImageLoader(urlString: "https://wgsi.utoronto.ca/wp-content/uploads/2020/12/blank-profile-picture-png.png") {_ in}
        }
    }

    var serviceProviderName:String {
        return "\(serviceProvider.firstName) \(serviceProvider.lastName)"
    }
    
    var specialties: String {
        return serviceProvider.specialties?.joined(separator: ",") ?? ""
    }
    
    var experience:String {
        return "\(getServiceProviderExperience()) years exp"
    }
    
    var fees:String {
        return "Fees: ₹\((serviceProvider.serviceFee ?? 0).clean)"
    }
    
    func getServiceProviderExperience () -> Int {
        var experienceInYears = 0
        if serviceProvider.experiences != nil {
            for exp in serviceProvider.experiences! {
                experienceInYears += yearsBetweenDate(startDate: Date(milliseconds: exp.startDate), endDate: Date(milliseconds: exp.endDate))
            }
            return experienceInYears
        } else {
            return 0
        }
    }
    
    func yearsBetweenDate(startDate: Date, endDate: Date) -> Int {

        let calendar = Calendar.current

        let components = calendar.dateComponents([.year], from: startDate, to: endDate)

        return components.year!
    }
    
    func takeToBookDocView () {
        self.callBack(serviceProvider)
    }
}
