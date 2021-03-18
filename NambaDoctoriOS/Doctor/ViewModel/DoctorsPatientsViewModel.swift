//
//  DoctorsPatientsViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import Foundation

class DoctorsPatientsViewModel: ObservableObject {
    @Published var patientList:[ServiceProviderCustomerProfile]?
    
    private var retrieveDoctorsPatientsService:RetrieveDoctorsPatientsServiceProtocol
    
    init(retrieveDoctorsPatientsService:RetrieveDoctorsPatientsServiceProtocol = RetrieveDoctorsPatientsService()) {
        
        self.retrieveDoctorsPatientsService = retrieveDoctorsPatientsService
        
        getPatients()
    }

    func getPatients () {
        self.retrieveDoctorsPatientsService.getDoctorsPatients { (patientList) in
            self.patientList = patientList
        }
    }
}
