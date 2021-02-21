//
//  RetrieveDocObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import Foundation

class RetrieveDocObj {
    
    var doctorObjectMapper:DoctorObjectMapper
    
    init(doctorObjectMapper:DoctorObjectMapper = DoctorObjectMapper()) {
        self.doctorObjectMapper = doctorObjectMapper
    }
    
    func getDoc (doctorId:String, _ completion : @escaping (_ DoctorObj:Doctor)->()) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let doctorClient = Nambadoctor_V1_DoctorWorkerv1Client(channel: channel)
        
        let request = Nambadoctor_V1_DoctorRequest.with {
            $0.doctorID = doctorId
        }

        let getDoctor = doctorClient.getDoctor(request, callOptions: callOptions)

        do {
            let response = try getDoctor.response.wait()
            let doctor = doctorObjectMapper.grpcToLocalDoctorObject(doctor: response)
            print("Get Doctor Client Success")
            completion(doctor)
        } catch {
            print("Get Doctor Client Failed")
        }
    }
}
