//
//  CustomerServiceProviderService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

protocol CustomerServiceProviderServiceProtocol {
    func getServiceProvider (serviceProviderId:String, _ completion : @escaping (_ DoctorObj:CustomerServiceProviderProfile?)->())
    func getAllServiceProvider (customerId:String, _ completion : @escaping (_ DoctorObj:[CustomerServiceProviderProfile]?)->())
    func getServiceProviderAvailabilities (serviceProviderId:String, _ completion : @escaping (_ DoctorObj:[CustomerGeneratedSlot]?)->())
    func getAllServiceProviderCategories (_ completion : @escaping (_ categories:[String]?)->())
}

class CustomerServiceProviderService : CustomerServiceProviderServiceProtocol {
    
    var serviceProviderMapper:CustomerServiceProviderProfileMapper
    var serviceProviderSlotMapper:CustomerGeneratedSlotMapper
    
    init(serviceProviderMapper:CustomerServiceProviderProfileMapper = CustomerServiceProviderProfileMapper(),
         serviceProviderSlotMapper:CustomerGeneratedSlotMapper = CustomerGeneratedSlotMapper()) {
        self.serviceProviderMapper = serviceProviderMapper
        self.serviceProviderSlotMapper = serviceProviderSlotMapper
    }
    
    func getServiceProvider (serviceProviderId:String, _ completion : @escaping (_ DoctorObj:CustomerServiceProviderProfile?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let serviceProviderClient = Nd_V1_CustomerServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = serviceProviderId.toProto
        }

        let getServiceProvider = serviceProviderClient.getServiceProviderProfile(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getServiceProvider.response.wait()
                let serviceProvider = self.serviceProviderMapper.grpcProfileToLocal(profile: response)
                print("Get ServiceProvider Client Success \(serviceProvider.serviceProviderID)")
                DispatchQueue.main.async {
                    completion(serviceProvider)
                }
            } catch {
                print("Get ServiceProvider Client Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    func getAllServiceProvider (customerId:String, _ completion : @escaping (_ DoctorObj:[CustomerServiceProviderProfile]?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let serviceProviderClient = Nd_V1_CustomerServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = customerId.toProto
        }

        let getServiceProvider = serviceProviderClient.getServiceProviders(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getServiceProvider.response.wait()
                let serviceProviders = self.serviceProviderMapper.grpcPhoneNumberToLocal(profiles: response.serviceProviders)
                print("Get ServiceProviders Client Success \(serviceProviders.count)")
                DispatchQueue.main.async {
                    completion(serviceProviders)
                }
            } catch {
                print("Get ServiceProvider Client Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func getServiceProviderAvailabilities (serviceProviderId:String, _ completion : @escaping (_ DoctorObj:[CustomerGeneratedSlot]?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let serviceProviderClient = Nd_V1_CustomerServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = serviceProviderId.toProto
        }

        let getServiceProviderSlots = serviceProviderClient.getServiceProviderAvailableSlots(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getServiceProviderSlots.response.wait()
                let slots = self.serviceProviderSlotMapper.grpcSlotToLocal(slots: response.slots)
                print("Get ServiceProviderSlots Client Success \(slots.count)")
                DispatchQueue.main.async {
                    completion(slots)
                }
            } catch {
                print("Get ServiceProviderSlots Client Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func getAllServiceProviderCategories (_ completion : @escaping (_ categories:[String]?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let serviceProviderClient = Nd_V1_CustomerServiceProviderWorkerV1Client(channel: channel)
        let getCategories = serviceProviderClient.getAllSpecialties(Nd_V1_VoidMessage(), callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                print("GETTING ALL CATEGORIES")
                let response = try getCategories.response.wait()
                print("Get CATEGORIES Client Success \(response.messages.count)")
                DispatchQueue.main.async {
                    completion(response.messages.convert())
                }
            } catch {
                print("Get CATEGORIES Client Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
