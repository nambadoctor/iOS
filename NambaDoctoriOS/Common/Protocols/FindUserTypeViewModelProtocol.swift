//
//  FindUserTypeViewModelProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 03/02/21.
//

import Foundation

protocol FindUserTypeViewModelProtocol {
    func logonUser (_ completion : @escaping (_ patientOrDoc:UserLoginStatus?)->())
}
