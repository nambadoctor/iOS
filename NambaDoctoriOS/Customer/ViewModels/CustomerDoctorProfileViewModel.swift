//
//  CustomerDoctorProfileViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/27/21.
//

import Foundation


class CustomerDoctorProfileViewModel : ObservableObject {
    var serviceProviderProfile:CustomerServiceProviderProfile
    var imageLoaderVM:ImageLoader
    
    init(serviceProviderProfile:CustomerServiceProviderProfile) {
        self.serviceProviderProfile = serviceProviderProfile
        self.imageLoaderVM = ImageLoader(urlString: serviceProviderProfile.profilePictureURL, { _ in })
    }
    
    var name : String {
        return "\(serviceProviderProfile.firstName) \(serviceProviderProfile.lastName)"
    }
    
    var educations : [String] {
        var educationString:[String] = [String]()
        
        if serviceProviderProfile.educations.isEmpty {
            educationString.append("Currently Not Available")
        } else {
            for education in serviceProviderProfile.educations {
                educationString.append(education.course)
            }
        }

        return educationString
    }
    
    var workExperience : [String] {
        var workExpString:[String] = [String]()
        
        if serviceProviderProfile.educations.isEmpty {
            workExpString.append("Currently Not Available")
        } else {
            for work in serviceProviderProfile.experiences {
                workExpString.append(work.organization)
            }
        }
        
        return workExpString
    }
    
    var specialties : [String] {
        return serviceProviderProfile.specialties
    }
}
