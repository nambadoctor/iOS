//
//  AddPreRegisteredViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation

class AddPreRegisteredViewModel {
    
    var patientObjMapper:PatientObjMapper
    
    init() {
        self.patientObjMapper = PatientObjMapper()
    }
    
    func preRegisterPatient(patientObj:Patient, _ completion : @escaping ((_ patientId:String?)->())) {

        CommonDefaultModifiers.showLoader()

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let patientClient = Nambadoctor_V1_PatientWorkerV1Client(channel: channel)
        
        let request = patientObjMapper.localPatientToGrpcObject(patient: patientObj)

        let putPatient = patientClient.writeNewPatientObject(request, callOptions: callOptions)

        do {
            let response = try putPatient.response.wait()
            print("Add Pre-Reg Patient Success \(response.patientID)")
            CommonDefaultModifiers.hideLoader()
            completion(response.patientID)
        } catch {
            print("Add Pre-Reg Patient Failure")
        }
    }
}
