//
//  ServiceProviderGetSetServiceCall.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

protocol ServiceProviderGetSetServiceCallProtocol {
    func setServiceProvider (serviceProvider:ServiceProviderProfile, _ completion : @escaping (_ id:String?)->())
    
    func getServiceProvider (serviceProviderId:String, _ completion : @escaping (_ DoctorObj:ServiceProviderProfile?)->())
    
    func getListOfPatients(serviceProviderId:String, _ completion: @escaping (([ServiceProviderCustomerProfile]?) -> ()))
}

class ServiceProviderGetSetServiceCall : ServiceProviderGetSetServiceCallProtocol {
    
    var serviceProviderMapper:ServiceProviderProfileMapper
    var customerObjectMapper:ServiceProviderCustomerProfileObjectMapper
    
    init(serviceProviderMapper:ServiceProviderProfileMapper = ServiceProviderProfileMapper(),
         customerObjectMapper:ServiceProviderCustomerProfileObjectMapper = ServiceProviderCustomerProfileObjectMapper()) {
        self.serviceProviderMapper = serviceProviderMapper
        self.customerObjectMapper = customerObjectMapper
    }
    
    func setServiceProvider (serviceProvider:ServiceProviderProfile, _ completion : @escaping (_ id:String?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let doctorClient = Nd_V1_ServiceProviderWorkerV1Client(channel: channel)
        
        let request = serviceProviderMapper.localProfileToGrpc(profile: serviceProvider)
        
        let getServiceProvider = doctorClient.setServiceProviderProfile(request, callOptions: callOptions)
        
        do {
            let response = try getServiceProvider.response.wait()
            print("Set Service Provider Success \(response.id)")
            completion(response.id.toString)
        } catch {
            print("Set Service Provider Failed")
            completion(nil)
        }
    }
    
    
    func getServiceProvider (serviceProviderId:String, _ completion : @escaping (_ DoctorObj:ServiceProviderProfile?)->()) {
        
        print("Getting service provider")
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let doctorClient = Nd_V1_ServiceProviderWorkerV1Client(channel: channel)
        print(serviceProviderId)
        
        let request = Nd_V1_IdMessage.with {
            //replace with serviceProviderId
            $0.id = "60554422a30a3a82f677ecb0".toProto
        }

        let getServiceProvider = doctorClient.getServiceProviderProfile(request, callOptions: callOptions)

        do {
            let response = try getServiceProvider.response.wait()
            let doctor = serviceProviderMapper.grpcProfileToLocal(profile: response)
            print("Get Doctor Client Success")
            completion(doctor)
        } catch {
            print("Get Doctor Client Failed")
            completion(nil)
        }
    }
    
    
    func getListOfPatients(serviceProviderId:String, _ completion: @escaping (([ServiceProviderCustomerProfile]?) -> ())) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let patientClient = Nd_V1_ServiceProviderCustomerWorkerV1Client(channel: channel)

        let request = Nd_V1_IdMessage.with {
            $0.id = serviceProviderId.toProto
        }

        let getDoctorsPatients = patientClient.getCustomers(request, callOptions: callOptions)

        DispatchQueue.main.async {
            do {
                let response = try getDoctorsPatients.response.wait()
                let patientList = self.customerObjectMapper.grpcCustomerToLocal(customer: response.customers)
                print("Doctors Patients received: success")
                completion(patientList)
            } catch {
                print("Doctors Patients received failed: \(error)")
                completion(nil)
            }
        }
    }

}
