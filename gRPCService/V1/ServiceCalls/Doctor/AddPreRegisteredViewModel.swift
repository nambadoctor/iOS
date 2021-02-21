//
//  AddPreRegisteredViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation

class AddPreRegisteredViewModel {
    
    var preRegPatientObjMapper:PreRegPatientObjectMapper
    
    init() {
        self.preRegPatientObjMapper = PreRegPatientObjectMapper()
    }
    
    func preRegisterPatient(patientObj:PreRegPatient, _ completion : @escaping ((_ patientId:String?)->())) {

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let patientClient = Nambadoctor_V1_PatientWorkerV1Client(channel: channel)
        
        let request = preRegPatientObjMapper.localPreRegPatientToGrpcObject(patient: patientObj)

        let putPatient = patientClient.writeNewPreRegObject(request, callOptions: callOptions)

        DispatchQueue.main.async {
            do {
                let response = try putPatient.response.wait()
                print("Add Pre-Reg Patient Success \(response.patientID)")
                completion(response.patientID)
            } catch {
                print("Add Pre-Reg Patient Failure")
                print(error)
            }
        }
    }
}
