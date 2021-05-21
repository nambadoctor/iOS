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
    
    func getListOfPatients(serviceProviderId:String, _ completion: @escaping (([ServiceProviderCustomerProfile]?) -> ()))
    
    func getServiceProviderAvailabilities(serviceProviderId:String, _ completion: @escaping (([ServiceProviderAvailability]?) -> ()))
    
    func setServiceProviderAvailabilities(serviceProviderId:String, availabilities:[ServiceProviderAvailability], _ completion: @escaping (_ success:Bool)->())
    
    func getAutofillMedicineList (_ completion: @escaping (([ServiceProviderAutofillMedicine]?) -> ()))
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
                    LoggerService().log(appointmentId: "", eventName: "Client Received Service Provider")
                    completion(response.id.toString)
                }
            } catch {
                print("Set Service Provider Failed")
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
                LoggerService().log(appointmentId: "", eventName: "REQUESTING SERVICE PROVIDER PROFILE")
                let response = try getServiceProvider.response.wait()
                LoggerService().log(appointmentId: "", eventName: "RECEIVED SERVICE PROVIDER PROFILE")
                let doctor = self.serviceProviderMapper.grpcProfileToLocal(profile: response)
                print("Get Doctor Client Success \(doctor.serviceProviderID)")
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


    func getListOfPatients(serviceProviderId:String, _ completion: @escaping (([ServiceProviderCustomerProfile]?) -> ())) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let patientClient = Nd_V1_ServiceProviderCustomerWorkerV1Client(channel: channel)

        let request = Nd_V1_IdMessage.with {
            $0.id = serviceProviderId.toProto
        }

        let getDoctorsPatients = patientClient.getCustomers(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getDoctorsPatients.response.wait()
                let patientList = self.customerObjectMapper.grpcCustomerToLocal(customer: response.customers)
                print("Doctors Patients received: success")
                DispatchQueue.main.async {
                    completion(patientList)
                }
            } catch {
                print("Doctors Patients received failed: \(error)")
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
                completion(ServiceProviderAutofillMedicineMapper.LocalToGrpc(medicines: response.medicines))
            } catch {
                print("Doctors AUTOFILL MEDICINES GET: failed \(error)")
                completion(nil)
            }
        }
    }
}
