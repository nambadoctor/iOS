//
//  GetSavedLoggedInDoctorObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 04/02/21.
//

import Foundation

//global variable for now. not singleton
var serviceProvider:ServiceProviderProfile?

class GetServiceProviderObject : GetDocObjectProtocol {
    
    func fetchDoctor (userId:String,
                      completion: @escaping (_ service_provider:ServiceProviderProfile)->())  {
        
        RetrieveDocObj().getDoc(serviceProviderId: userId, { serviceProviderObj in
            serviceProvider = serviceProviderObj
            completion(serviceProviderObj)
        })
    }
    
    func getDoctor () -> ServiceProviderProfile {
        return serviceProvider!
    }
}
