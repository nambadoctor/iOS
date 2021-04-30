//
//  CustomerServiceRequestService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

protocol CustomerServiceRequestServiceProtocol {
    func getServiceRequest (appointmentId:String,
                            serviceRequestId:String,
                            customerId:String,
                            completion: @escaping ((_ serviceRequest:CustomerServiceRequest?)->()))
    func setServiceRequest (serviceRequest:CustomerServiceRequest,
                            completion: @escaping ((_ responseId:String?)->()))
}

class CustomerServiceRequestService : CustomerServiceRequestServiceProtocol {
    var serviceRequestMapper:CustomerServiceRequestMapper
    
    init(serviceRequestMapper:CustomerServiceRequestMapper = CustomerServiceRequestMapper()) {
        self.serviceRequestMapper = serviceRequestMapper
    }
    
    func getServiceRequest (appointmentId:String,
                            serviceRequestId:String,
                            customerId:String,
                            completion: @escaping ((_ serviceRequest:CustomerServiceRequest?)->())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let serviceRequestClient = Nd_V1_CustomerServiceRequestWorkerV1Client(channel: channel)
        
        let request = Nd_V1_CustomerServiceRequestRequestMessage.with {
            $0.appointmentID = appointmentId.toProto
            $0.customerID = customerId.toProto
            $0.serviceRequestID = serviceRequestId.toProto
        }

        let getServiceRequestObj = serviceRequestClient.getServiceRequest(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getServiceRequestObj.response.wait()
                let serviceRequest = self.serviceRequestMapper.grpcServiceRequestToLocal(serviceRequest: response)
                print(serviceRequest)
                print("ServiceRequestClient received: \(response)")
                DispatchQueue.main.async {
                    completion(serviceRequest)
                }
            } catch {
                print("ServiceRequestClient failed: \(error)")
            }
        }
    }

    func setServiceRequest (serviceRequest:CustomerServiceRequest,
                            completion: @escaping ((_ responseId:String?)->())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let serviceRequestClient = Nd_V1_CustomerServiceRequestWorkerV1Client(channel: channel)
        
        let request = serviceRequestMapper.localServiceRequestToGrpc(serviceRequest: serviceRequest)

        let getServiceRequestObj = serviceRequestClient.setServiceRequest(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getServiceRequestObj.response.wait()
                print("ServiceRequest Set Client received: \(response.id.toString)")
                DispatchQueue.main.async {
                    completion(response.id.toString)
                }
            } catch {
                print("ServiceRequest Set Client failed: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

}
