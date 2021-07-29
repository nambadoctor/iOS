//
//  ServiceProviderGetSetServiceCall.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

protocol ServiceProviderProfileServiceProtocol {
    func setServiceProvider (serviceProvider:ServiceProviderProfile, _ completion : @escaping (_ id:String?)->())
    
    func getServiceProvider (serviceProviderId:String, _ completion : @escaping (_ DoctorObj:ServiceProviderProfile?)->())
    
    func getServiceProviderAvailabilities(serviceProviderId:String, _ completion: @escaping (([ServiceProviderAvailability]?) -> ()))
    
    func setServiceProviderAvailabilities(serviceProviderId:String, availabilities:[ServiceProviderAvailability], _ completion: @escaping (_ success:Bool)->())
    
    func getAutofillMedicineList (_ completion: @escaping (([ServiceProviderAutofillMedicine]?) -> ()))
    
    func setNewMedicineList (medicines:[ServiceProviderMedicine] ,_ completion: @escaping (Bool) -> ())
    
    func getServiceProviders (serviceProviderId:String, _ completion : @escaping (_ serviceProviders:[ServiceProviderProfile]?)->())
    
    func getServiceProvidersOfOrganization (organizationId:String, _ completion : @escaping (_ serviceProviders:[ServiceProviderProfile]?)->())
}

class ServiceProviderProfileService : ServiceProviderProfileServiceProtocol {
    
    var serviceProviderMapper:ServiceProviderProfileMapper
    var customerObjectMapper:ServiceProviderCustomerProfileObjectMapper
    
    private var stopwatch = StopwatchManager(callingClass: "SERVICE_PROVIDER_GET")
    
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
        
        DispatchQueue.global().async {
            do {
                CorrelationId = UUID().uuidString
                let response = try getServiceProvider.response.wait()
                print("Set Service Provider Success \(response.id)")
                DispatchQueue.main.async {
                    LoggerService().log(eventName: "Client Set Service Provider")
                    completion(response.id.toString)
                }
            } catch {
                print("Set Service Provider Failed \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    func getServiceProvider (serviceProviderId:String, _ completion : @escaping (_ DoctorObj:ServiceProviderProfile?)->()) {
        CorrelationId = UUID().uuidString
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let doctorClient = Nd_V1_ServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = serviceProviderId.toProto
        }

        let getServiceProvider = doctorClient.getServiceProviderProfile(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                LoggerService().log(eventName: "REQUESTING SERVICE PROVIDER PROFILE")
                let response = try getServiceProvider.response.wait()
                LoggerService().log(eventName: "RECEIVED SERVICE PROVIDER PROFILE")
                let doctor = self.serviceProviderMapper.grpcProfileToLocal(profile: response)
                print("Get Doctor Client Success \(doctor)")
                DispatchQueue.main.async {
                    completion(doctor)
                }
            } catch {
                print("Get Doctor Client Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    func getServiceProviderAvailabilities(serviceProviderId:String, _ completion: @escaping (([ServiceProviderAvailability]?) -> ())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let serviceProviderClient = Nd_V1_ServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = serviceProviderId.toProto
        }

        let getDoctorsPatients = serviceProviderClient.getServiceProviderAvailablity(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getDoctorsPatients.response.wait()
                let availabilityList = ServiceProviderAvailaibilityObjectMapper.grpcAvailabilityToLocal(availability: response.availabilityList)
                print("Doctors Availability received: success")
                DispatchQueue.main.async {
                    completion(availabilityList)
                }
            } catch {
                print("Doctors Availability received failed: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func setServiceProviderAvailabilities(serviceProviderId:String, availabilities: [ServiceProviderAvailability], _ completion: @escaping (Bool) -> ()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let serviceProviderClient = Nd_V1_ServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_ServiceProviderAvailabilityRequest.with {
            $0.availabilityList = ServiceProviderAvailaibilityObjectMapper.localAvailabilityToGrpc(availability: availabilities)
            $0.serviceProviderID = serviceProviderId.toProto
        }

        let getDoctorsPatients = serviceProviderClient.setServiceProviderAvailability(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getDoctorsPatients.response.wait()
                print("Doctors Availability SET: success")
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                print("Doctors Availability SET failed: \(error)")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    func getAutofillMedicineList (_ completion: @escaping (([ServiceProviderAutofillMedicine]?) -> ())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let serviceProviderClient = Nd_V1_ServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = "".toProto
        }

        let getAutofillMedicines = serviceProviderClient.getAutoFillMedicines(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getAutofillMedicines.response.wait()
                print("Doctors AUTOFILL MEDICINES GET: success")
                completion(ServiceProviderAutofillMedicineMapper.GrpcToLocal(medicines: response.medicines))
            } catch {
                print("Doctors AUTOFILL MEDICINES GET: failed \(error)")
                completion(nil)
            }
        }
    }
    
    func setNewMedicineList (medicines:[ServiceProviderMedicine] ,_ completion: @escaping (Bool) -> ()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let serviceProviderClient = Nd_V1_ServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_ServiceProviderMedicineMessageList.with {
            $0.medicines = ServiceProviderMedicineMapper.localMedicineToGrpc(medicines: medicines)
        }

        let getAutofillMedicines = serviceProviderClient.setAutoFillMedicines(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getAutofillMedicines.response.wait()
                print("Doctors NEW AUTOFILL MEDICINES SET: success \(response)")
                completion(true)
            } catch {
                print("Doctors NEW AUTOFILL MEDICINES SET: failed \(error)")
                completion(false)
            }
        }
    }
    
    func getServiceProviders (serviceProviderId:String, _ completion : @escaping (_ serviceProviders:[ServiceProviderProfile]?)->()) {
        CorrelationId = UUID().uuidString
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let doctorClient = Nd_V1_ServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = serviceProviderId.toProto
        }

        let getServiceProvider = doctorClient.getServiceProviders(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                LoggerService().log(eventName: "REQUESTING SERVICE PROVIDERs")
                let response = try getServiceProvider.response.wait()
                LoggerService().log(eventName: "RECEIVED SERVICE PROVIDERs")
                let serviceProviders = self.serviceProviderMapper.grpcProfileToLocal(profile: response.serviceProviders)
                print("Get Service Providers Client Success \(serviceProviders)")
                DispatchQueue.main.async {
                    completion(serviceProviders)
                }
            } catch {
                print("Get Service Providers Client Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func getServiceProvidersOfOrganization (organizationId:String, _ completion : @escaping (_ serviceProviders:[ServiceProviderProfile]?)->()) {
        CorrelationId = UUID().uuidString
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let doctorClient = Nd_V1_ServiceProviderWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = organizationId.toProto
        }

        let getServiceProvider = doctorClient.getServiceProvidersOfOrganisation(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                LoggerService().log(eventName: "REQUESTING SERVICE PROVIDERS of Organization")
                let response = try getServiceProvider.response.wait()
                LoggerService().log(eventName: "RECEIVED SERVICE PROVIDERs of Organization")
                let serviceProviders = self.serviceProviderMapper.grpcProfileToLocal(profile: response.serviceProviders)
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
}
