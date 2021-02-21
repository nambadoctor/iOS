//
//  RetrieveDoctorsPatientsService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import Foundation

class RetrieveDoctorsPatientsService : RetrieveDoctorsPatientsServiceProtocol {
    
    var patientObjMapper:PatientObjMapper
    
    init(patientObjMapper:PatientObjMapper = PatientObjMapper()) {
        self.patientObjMapper = patientObjMapper
    }

    
    func getDoctorsPatients(_ completion: @escaping (([Patient]?) -> ())) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let patientClient = Nambadoctor_V1_PatientWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_DoctorsRequest.with {
            $0.doctorID = doctor!.doctorID
        }

        let getDoctorsPatients = patientClient.getListOfDoctorsPatients(request, callOptions: callOptions)

        DispatchQueue.main.async {
            do {
                let response = try getDoctorsPatients.response.wait()
                let patientList = self.patientObjMapper.grpcPatientsListToLocal(patientList: response.patientObject)
                print("Doctors Patients received: success")
                completion(patientList)
            } catch {
                print("Doctors Patients received failed: \(error)")
                completion(nil)
            }
        }
    }

}
