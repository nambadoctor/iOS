//
//  GetSavedLoggedInDoctorObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 04/02/21.
//

import Foundation

class GetDocObject {
    static let docHelper = GetDocObject()
    private var doctor:Nambadoctor_V1_DoctorResponse?

    init(){}
    
    func fetchDoctor (userId:String, completion: @escaping (_ doctor:Nambadoctor_V1_DoctorResponse)->())  {
        RetrieveDocObj().getDoc(doctorId:userId) { docObj in
            self.doctor = docObj
            completion(docObj)
        }
    }
    
    func getDoctor () -> Nambadoctor_V1_DoctorResponse {
        return doctor!
    }
}
