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
                print("Set Customer Failed")
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
}
