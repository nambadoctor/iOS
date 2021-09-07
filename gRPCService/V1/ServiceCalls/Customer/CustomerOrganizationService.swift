//
//  CustomerOrganizationService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/20/21.
//

import Foundation

class CustomerOrganizationService {
    func getcustomerOrganization (organizationId:String, _ completion : @escaping (_ Organization:CustomerOrganization?)->()) {
        CorrelationId = UUID().uuidString
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let orgClient = Nd_V1_CustomerOrganisationWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = organizationId.toProto
        }

        let getOrganisation = orgClient.getOrganisation(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                LoggerService().log(eventName: "REQUESTING Organization")
                let response = try getOrganisation.response.wait()
                LoggerService().log(eventName: "RECEIVED Organization")
                let org = CustomerOrganisationMapper.GrpcToLocal(organization: response)
                print("Get Organization Success \(org)")
                DispatchQueue.main.async {
                    completion(org)
                }
            } catch {
                print("Get Organization Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    func getCustomerOrganizations (customerId:String, _ completion : @escaping (_ Organizations:[CustomerOrganization]?)->()) {
        CorrelationId = UUID().uuidString
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let orgClient = Nd_V1_CustomerOrganisationWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = customerId.toProto
        }

        let getOrganisation = orgClient.getOrganisations(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                LoggerService().log(eventName: "REQUESTING Organizations")
                let response = try getOrganisation.response.wait()
                LoggerService().log(eventName: "RECEIVED Organizations")
                let orgs = CustomerOrganisationMapper.GrpcToLocal(organization: response.organisations)
                print("Get Organizations Success \(orgs)")
                DispatchQueue.main.async {
                    completion(orgs)
                }
            } catch {
                print("Get Organizations Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func getCustomerSpecificOrganizations (orgIds:[String], _ completion : @escaping (_ Organizations:[CustomerOrganization]?)->()) {
        CorrelationId = UUID().uuidString
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let orgClient = Nd_V1_CustomerOrganisationWorkerV1Client(channel: channel)
        
        let request = Nd_V1_StringArrayMessage.with {
            $0.messages = orgIds.convert()
        }
        
        let getOrganisation = orgClient.getSpecificOrganisations(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                LoggerService().log(eventName: "REQUESTING specific Organizations")
                let response = try getOrganisation.response.wait()
                LoggerService().log(eventName: "RECEIVED specific Organizations")
                let orgs = CustomerOrganisationMapper.GrpcToLocal(organization: response.organisations)
                print("Get specific Organizations Success \(orgs)")
                DispatchQueue.main.async {
                    completion(orgs)
                }
            } catch {
                print("Get specific Organizations Failed \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
}
