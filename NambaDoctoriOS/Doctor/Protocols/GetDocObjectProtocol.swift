//
//  GetDocObjectProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation

protocol GetDocObjectProtocol {
    func fetchDoctor (userId:String, completion: @escaping (_ doctor:Doctor)->())
    func getDoctor () -> Doctor
}
