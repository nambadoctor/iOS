//
//  GetSavedLoggedInDoctorObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 04/02/21.
//

import Foundation

//global variable for now. not singleton
var doctor:Doctor?

class GetDocObject : GetDocObjectProtocol {
    func fetchDoctor (userId:String, completion: @escaping (_ doctor:Doctor)->())  {
        RetrieveDocObj().getDoc(doctorId:userId) { docObj in
            doctor = docObj
            completion(docObj)
        }
    }
    
    func getDoctor () -> Doctor {
        return doctor!
    }
}
