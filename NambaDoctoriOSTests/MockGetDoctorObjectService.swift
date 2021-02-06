//
//  MockGetDoctorObject.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockGetDoctorObjectService : GetDocObjectProtocol {
    func fetchDoctor (userId:String, completion: @escaping (_ doctor:Nambadoctor_V1_DoctorResponse)->()) {
        completion(MockDoctor.getDoctor())
    }
    func getDoctor () -> Nambadoctor_V1_DoctorResponse {
        return MockDoctor.getDoctor()
    }
}
