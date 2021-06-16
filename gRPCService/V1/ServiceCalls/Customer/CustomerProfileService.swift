//
//  CustomerProfileService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

protocol CustomerProfileServiceProtocol {
    func setCustomerProfile (customerProfile:CustomerProfile, _ completion : @escaping (_ id:String?)->())
    func getCustomerProfile (customerId:String, _ completion : @escaping (_ customerObj:CustomerProfile?)->())
    func setChildProfile (child:CustomerChildProfile, _ completion : @escaping (_ id:String?)->())
}

class CustomerProfileService : CustomerProfileServiceProtocol {
    var customerProfileMapper:CustomerProfileMapper
    
    init(customerProfileMapper:CustomerProfileMapper = CustomerProfileMapper()) {
        self.customerProfileMapper = customerProfileMapper
    }
    
    func setCustomerProfile (customerProfile:CustomerProfile, _ completion : @escaping (_ id:String?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        let customerClient = Nd_V1_CustomerWorkerV1Client(channel: channel)
        
        let request = customerProfileMapper.localCustomerToGrpc(customer: customerProfile)
        
        let setCustomerProfile = customerClient.setCustomerProfile(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try setCustomerProfile.response.wait()
                print("Set Customer Success \(response.id)")
                DispatchQueue.main.async {
                    completion(response.id.toString)
                }
            } catch {
                print("Set Customer Failed \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    func getCustomerProfile (customerId:String, _ completion : @escaping (_ customerObj:CustomerProfile?)->()) {
        let stopwatch = StopwatchManager(callingClass: "CUSTOMER PROFILE")
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        let customerCLient = Nd_V1_CustomerWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = customerId.toProto
        }

        let getCustomer = customerCLient.getCustomerProfile(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                print("GETTING CUSTOMER PROFILE: \(customerId)")
                stopwatch.start()
                let response = try getCustomer.response.wait()
                stopwatch.stop()
                let customer = self.customerProfileMapper.grpcCustomerToLocal(customer: response)
                print("Get Customer Success \(customer.customerID)")
                DispatchQueue.main.async {
                    completion(customer)
                }
            } catch {
                print("Get Customer Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func setChildProfile(child: CustomerChildProfile, _ completion: @escaping (String?) -> ()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        let customerCLient = Nd_V1_CustomerWorkerV1Client(channel: channel)
        
        let request = Nd_V1_CustomerChildProfileUploadMessage.with {
            $0.childProfile = CustomerChildProfileMapper.LocalToGrpc(child: child)
            $0.caretakerID = UserIdHelper().retrieveUserId().toProto
        }

        let setChild = customerCLient.setChildProfile(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                print("SETTING CUSTOMER CHILD PROFILE: \(UserIdHelper().retrieveUserId())")
                let response = try setChild.response.wait()
                print("SETTING CUSTOMER CHILD PROFILE Success \(response)")
                DispatchQueue.main.async {
                    completion(response.id.toString)
                }
            } catch {
                print("SETTING CUSTOMER CHILD PROFILE Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
