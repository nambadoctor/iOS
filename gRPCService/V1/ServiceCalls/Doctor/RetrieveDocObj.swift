//
//  RetrieveDocObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import Foundation

class RetrieveDocObj {
    
    var serviceProviderMapper:ServiceProviderProfileMapper
    
    init(serviceProviderMapper:ServiceProviderProfileMapper = ServiceProviderProfileMapper()) {
        self.serviceProviderMapper = serviceProviderMapper
    }
    
    func getDoc (serviceProviderId:String, _ completion : @escaping (_ DoctorObj:ServiceProviderProfile)->()) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let doctorClient = Nd_V1_ServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = serviceProviderId.toProto
        }

        let getServiceProvider = doctorClient.getServiceProviderProfile(request, callOptions: callOptions)

        do {
            let response = try getServiceProvider.response.wait()
            let doctor = serviceProviderMapper.grpcProfileToLocal(profile: response)
            print("Get Doctor Client Success")
            completion(doctor)
        } catch {
            print("Get Doctor Client Failed")
        }
    }
}
