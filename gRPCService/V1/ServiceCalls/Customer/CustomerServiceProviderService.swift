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
    func getAllServiceProviderCategories (_ completion : @escaping (_ categories:[Category]?)->())
    func getServiceProvidersOfOrganization (organizationId:String, _ completion : @escaping (_ serviceProviders:[CustomerServiceProviderProfile]?)->())
    func getServiceProviderAvailableSlotsForOrganisation (serviceProviderId:String, organizationId:String, _ completion : @escaping (_ DoctorObj:[CustomerGeneratedSlot]?)->())
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
                let serviceProviders = self.serviceProviderMapper.grpcProfileToLocal(profiles: response.serviceProviders)
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
    
    func getAllServiceProviderCategories (_ completion : @escaping (_ categories:[Category]?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let serviceProviderClient = Nd_V1_CustomerServiceProviderWorkerV1Client(channel: channel)
        let getCategories = serviceProviderClient.getAllSpecialties(Nd_V1_VoidMessage(), callOptions: callOptions)
        
        func getAllDoctorsFirst (categories:[Category]) -> [Category] {
            var categoriesToReturn:[Category] = categories
            
            for index in 0..<categoriesToReturn.count {
                if categoriesToReturn[index].CategoryName == "All Doctors" {
                    var tempCategory = categoriesToReturn[index]
                    categoriesToReturn.remove(at: index)
                    categoriesToReturn.insert(tempCategory, at: 0)
                }
            }

            return categoriesToReturn
        }
        
        DispatchQueue.global().async {
            do {
                print("GETTING ALL CATEGORIES")
                let response = try getCategories.response.wait()
                let categories = SpecialtyCategoryMapper().GrpcToLocalCategory(categories: response.categories)
                print("Get CATEGORIES Client Success \(categories)")
                DispatchQueue.main.async {
                    completion(getAllDoctorsFirst(categories: categories))
                }
            } catch {
                print("Get CATEGORIES Client Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion([Category(CategoryId: "", CategoryName: "All Doctors", CategoryThumbnail: "")])
                }
            }
        }
    }

    func getServiceProvidersOfOrganization (organizationId:String, _ completion : @escaping (_ serviceProviders:[CustomerServiceProviderProfile]?)->()) {
        CorrelationId = UUID().uuidString
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let doctorClient = Nd_V1_CustomerServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = organizationId.toProto
        }

        let getServiceProvider = doctorClient.getServiceProviders(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                LoggerService().log(eventName: "REQUESTING SERVICE PROVIDERS of Organization")
                let response = try getServiceProvider.response.wait()
                LoggerService().log(eventName: "RECEIVED SERVICE PROVIDERs of Organization")
                let serviceProviders = CustomerServiceProviderProfileMapper().grpcProfileToLocal(profiles: response.serviceProviders)
                print("Get Service Providers of Organization Client Success \(serviceProviders)")
                DispatchQueue.main.async {
                    completion(serviceProviders)
                }
            } catch {
                print("Get Service Providers of Organization Client Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func getServiceProviderAvailableSlotsForOrganisation (serviceProviderId:String, organizationId:String, _ completion : @escaping (_ DoctorObj:[CustomerGeneratedSlot]?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let serviceProviderClient = Nd_V1_CustomerServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_CustomerServiceProviderInOrganisationRequestMessage.with {
            $0.organisationID = organizationId.toProto
            $0.serviceProviderID = serviceProviderId.toProto
        }

        let getServiceProviderSlots = serviceProviderClient.getServiceProviderAvailableSlotsForOrganisation(request, callOptions: callOptions)

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
}
