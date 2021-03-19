//
//  RetrieveServiceRequestProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

protocol ServiceRequestGetSetCallProtocol {
    func getServiceRequest (appointmentId:String,
                            serviceRequestId:String,
                            customerId:String,
                            completion: @escaping ((_ serviceRequest:ServiceProviderServiceRequest?)->()))
    
    func setServiceRequest (serviceRequest:ServiceProviderServiceRequest,
                            completion: @escaping ((_ responseId:String?)->()))
}
