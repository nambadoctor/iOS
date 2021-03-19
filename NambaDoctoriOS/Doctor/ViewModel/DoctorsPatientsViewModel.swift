//
//  DoctorsPatientsViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import Foundation

class DoctorsPatientsViewModel: ObservableObject {
    @Published var patientList:[ServiceProviderCustomerProfile]?
    
    private let ServiceProviderServiceCall:ServiceProviderGetSetServiceCallProtocol
    
    init(ServiceProviderServiceCall:ServiceProviderGetSetServiceCallProtocol = ServiceProviderGetSetServiceCall()) {
        
        self.ServiceProviderServiceCall = ServiceProviderServiceCall
    }

    func getPatients (serviceProviderId:String) {
        self.ServiceProviderServiceCall.getListOfPatients(serviceProviderId: serviceProviderId) { (patientList) in
            self.patientList = patientList
        }
    }
}
