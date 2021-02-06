//
//  GetSavedLoggedInDoctorObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 04/02/21.
//

import Foundation

//global variable for now. not singleton
var doctor:Nambadoctor_V1_DoctorResponse?

class GetDocObject : GetDocObjectProtocol {
    func fetchDoctor (userId:String, completion: @escaping (_ doctor:Nambadoctor_V1_DoctorResponse)->())  {
        RetrieveDocObj().getDoc(doctorId:userId) { docObj in
            doctor = docObj
            completion(docObj)
        }
    }
    
    func getDoctor () -> Nambadoctor_V1_DoctorResponse {
        return doctor!
    }
}
