//
//  RetrieveDocObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import Foundation

class RetrieveDocObj {
    func getDoc (doctorId:String, _ completion : @escaping (_ DoctorObj:Nambadoctor_V1_DoctorResponse)->()) {

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let doctorClient = Nambadoctor_V1_DoctorWorkerv1Client(channel: channel)
        
        let request = Nambadoctor_V1_DoctorRequest.with {
            $0.doctorID = doctorId
        }
        
        let getDoctor = doctorClient.getDoctor(request)
        
        do {
            let response = try getDoctor.response.wait()
            print("Get Doctor Client Success")
            completion(response)
        } catch {
            print("Get Doctor Client Failed")
        }
    }
}
