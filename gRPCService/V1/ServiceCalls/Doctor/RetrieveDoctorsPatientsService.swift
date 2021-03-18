//
//  RetrieveDoctorsPatientsService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import Foundation

class RetrieveDoctorsPatientsService : RetrieveDoctorsPatientsServiceProtocol {
    
    var customerObjMapper:ServiceProviderCustomerProfileObjectMapper
    
    init(customerObjMapper:ServiceProviderCustomerProfileObjectMapper = ServiceProviderCustomerProfileObjectMapper()) {
        self.customerObjMapper = customerObjMapper
    }

    
    func getDoctorsPatients(_ completion: @escaping (([ServiceProviderCustomerProfile]?) -> ())) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let patientClient = Nd_V1_ServiceProviderCustomerWorkerV1Client(channel: channel)

        let request = Nd_V1_IdMessage.with {
            $0.id = "".toProto
        }

        let getDoctorsPatients = patientClient.getCustomers(request, callOptions: callOptions)

        DispatchQueue.main.async {
            do {
                let response = try getDoctorsPatients.response.wait()
                let patientList = self.customerObjMapper.grpcCustomerToLocal(customer: response.customers)
                print("Doctors Patients received: success")
                completion(patientList)
            } catch {
                print("Doctors Patients received failed: \(error)")
                completion(nil)
            }
        }
    }

}
