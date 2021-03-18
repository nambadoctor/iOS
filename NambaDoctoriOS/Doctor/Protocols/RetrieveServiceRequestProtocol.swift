//
//  RetrieveServiceRequestProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

protocol RetrieveServiceRequestProtocol {
    func getServiceRequest (appointmentId:String, serviceRequestId:String, customerId:String, _ completion: @escaping ((_ serviceRequest:ServiceProviderServiceRequest?)->()))
}
