//
//  RetrievePatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import SwiftUI

protocol ServiceProviderCustomerServiceProtocol {
    func setPatientProfile (customerProfile:ServiceProviderCustomerProfile,
                            completion: @escaping (_ returnId:String?) -> ())
    func getPatientProfile(patientId: String,
                           completion: @escaping (_ profile:ServiceProviderCustomerProfile?) -> ())
}

class ServiceProviderCustomerService: ServiceProviderCustomerServiceProtocol {
    
    var customerObjMapper:ServiceProviderCustomerProfileObjectMapper
    var reportObjMapper:ServiceProviderReportMapper
    
    init(
        customerObjMapper:ServiceProviderCustomerProfileObjectMapper = ServiceProviderCustomerProfileObjectMapper(),
        reportObjMapper:ServiceProviderReportMapper = ServiceProviderReportMapper()) {
        self.customerObjMapper = customerObjMapper
        self.reportObjMapper = reportObjMapper
    }
    
    func setPatientProfile (customerProfile:ServiceProviderCustomerProfile,
                            completion: @escaping (_ returnId:String?) -> ()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        // Provide the connection to the generated client.
        let patientClient = Nd_V1_ServiceProviderCustomerWorkerV1Client(channel: channel)
        
        let request = customerObjMapper.localCustomerToGrpc(customer: customerProfile)
        
        let getPatientObject = patientClient.setCustomerProfile(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getPatientObject.response.wait()
                print("Customer Client Set Success: \(response.id)")
                DispatchQueue.main.async {
                    completion(response.id.toString)
                }
            } catch {
                print("Customer Client Set failed: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                
            }
        }
    }
    
    func getPatientProfile(patientId: String,
                           completion: @escaping (_ profile:ServiceProviderCustomerProfile?) -> ()) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let patientClient = Nd_V1_ServiceProviderCustomerWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = patientId.toProto
        }
        
        let getPatientObject = patientClient.getCustomerProfile(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getPatientObject.response.wait()
                let customer = self.customerObjMapper.grpcCustomerToLocal(customer: response)
                print("Customer Client received: \(response.customerID)")
                DispatchQueue.main.async {
                    completion(customer)
                }
            } catch {
                print("Customer Client failed: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
