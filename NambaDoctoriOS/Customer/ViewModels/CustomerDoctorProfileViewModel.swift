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
    var generateLinkCallBack:()->()
    
    init(serviceProviderProfile:CustomerServiceProviderProfile, generateLinkCallBack:@escaping ()->()) {
        self.serviceProviderProfile = serviceProviderProfile
        self.imageLoaderVM = ImageLoader(urlString: serviceProviderProfile.profilePictureURL, { _ in })
        self.generateLinkCallBack = generateLinkCallBack
    }
    
    var name : String {
        return "\(serviceProviderProfile.firstName) \(serviceProviderProfile.lastName)"
    }

    var educations : [String] {
        var educationString:[String] = [String]()
        
        for education in serviceProviderProfile.educations {
            educationString.append(education.course)
        }
        
        return educationString
    }
    
    var workExperience : [String] {
        var workExpString:[String] = [String]()
        
        for work in serviceProviderProfile.experiences {
            workExpString.append(work.organisation)
        }
        
        return workExpString
    }
    
    var getAllWorkExperience:Int {
        var totalExperience : Int = 0
        
        for work in serviceProviderProfile.experiences {
            totalExperience += Helpers.getDateDifferenceInYears(timeStamp1: work.startDate, timeStamp2: work.endDate)
        }
        
        return totalExperience
    }
    
    var specialties : [String] {
        return serviceProviderProfile.specialties
    }
}
