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
    
    func getListOfPatients(serviceProviderId:String, _ completion: @escaping (([ServiceProviderMyPatientProfile]?) -> ()))
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
                print("Customer Client received: \(response)")
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
    
    func getListOfPatients(serviceProviderId:String, _ completion: @escaping ([ServiceProviderMyPatientProfile]?) -> ()) {
                
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
                let patientList = ServiceProviderMyPatientProfileMapper.GrpcToLocal(profileMessages: response.myPatients)
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
    
    func getAppointmentSummary (parentCustomerId:String, serviceProviderId:String, childId:String, _ completion: @escaping ([ServiceProviderAppointmentSummary]?) -> ()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        // Provide the connection to the generated client.
        let patientClient = Nd_V1_ServiceProviderCustomerWorkerV1Client(channel: channel)

        let request = Nd_V1_ServiceProviderAppointmentSummaryRequestMessage.with {
            $0.parentCustomerID = parentCustomerId.toProto
            $0.serviceProviderID = serviceProviderId.toProto
            $0.childID = childId.toProto
        }

        let getAppointmentSummary = patientClient.getCustomerAppointmentSummary(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getAppointmentSummary.response.wait()
                let appointmentSummary = ServiceProviderAppointmentSummaryMapper.GrpcToLocal(appointmentSummary: response.serviceProviderAppointmentSummaryList)
                print("Appointment Summary received: success")
                DispatchQueue.main.async {
                    completion(appointmentSummary)
                }
            } catch {
                print("Appointment Summary received failed: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func getCustomersOfOrganisation(organisation:String, serviceProviderId:String, _ completion: @escaping ([ServiceProviderMyPatientProfile]?) -> ()) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let patientClient = Nd_V1_ServiceProviderCustomerWorkerV1Client(channel: channel)

        let request = Nd_V1_ServiceProviderInOrganisationRequestMessage.with {
            $0.organisationID = organisation.toProto
            $0.serviceProviderID = serviceProviderId.toProto
        }

        let getDoctorsPatients = patientClient.getCustomersOfOrganisation(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                LoggerService().log(eventName: "REQUESTING Doctors Get Customer of org")
                let response = try getDoctorsPatients.response.wait()
                LoggerService().log(eventName: "RECIEVED Doctors Get Customer of org")
                let patientList = ServiceProviderMyPatientProfileMapper.GrpcToLocal(profileMessages: response.myPatients)
                print("Doctors Get Customer of org received: success")
                DispatchQueue.main.async {
                    completion(patientList)
                }
            } catch {
                print("Doctors Get Customer of org failed: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func GetCustomersOfServiceProviderInOrganisation(organisation:String, serviceProviderId:String, _ completion: @escaping ([ServiceProviderMyPatientProfile]?) -> ()) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        // Provide the connection to the generated client.
        let patientClient = Nd_V1_ServiceProviderCustomerWorkerV1Client(channel: channel)

        let request = Nd_V1_ServiceProviderInOrganisationRequestMessage.with {
            $0.organisationID = organisation.toProto
            $0.serviceProviderID = serviceProviderId.toProto
        }

        let getDoctorsPatients = patientClient.getCustomersOfServiceProviderInOrganisation(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                LoggerService().log(eventName: "REQUESTING Get Customer of Doctor in org")
                let response = try getDoctorsPatients.response.wait()
                LoggerService().log(eventName: "RECIEVED Doctors Get Customer of Doctor in org")
                let patientList = ServiceProviderMyPatientProfileMapper.GrpcToLocal(profileMessages: response.myPatients)
                print("Doctors Get Customer of org received: success")
                DispatchQueue.main.async {
                    completion(patientList)
                }
            } catch {
                print("Get Customer of Doctor in org failed: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
