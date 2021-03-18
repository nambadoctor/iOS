//
//  RetrieveServiceRequestViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

class RetrieveServiceRequestViewModel : RetrieveServiceRequestProtocol {
    
    var serviceRequestMapper:ServiceProviderServiceRequestMapper
    
    init(serviceRequestMapper:ServiceProviderServiceRequestMapper = ServiceProviderServiceRequestMapper()) {
        self.serviceRequestMapper = serviceRequestMapper
    }
    
    func getServiceRequest (appointmentId:String, serviceRequestId:String, customerId:String, _ completion: @escaping ((_ serviceRequest:ServiceProviderServiceRequest?)->())) {
        
        CommonDefaultModifiers.showLoader()

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let serviceRequestClient = Nd_V1_ServiceProviderServiceRequestWorkerV1Client(channel: channel)
        
        let request = Nd_V1_ServiceProviderServiceRequestRequestMessage.with {
            $0.appointmentID = appointmentId.toProto
            $0.customerID = customerId.toProto
            $0.serviceRequestID = serviceRequestId.toProto
        }

        let getServiceRequestObj = serviceRequestClient.getServiceRequest(request, callOptions: callOptions)
        
        do {
            let response = try getServiceRequestObj.response.wait()
            let serviceRequest = serviceRequestMapper.grpcServiceRequestToLocal(serviceRequest: response)
            print("ServiceRequestClient received: \(response)")
            CommonDefaultModifiers.hideLoader()
            completion(serviceRequest)
        } catch {
            print("ServiceRequestClient failed: \(error)")
        }
    }
}
