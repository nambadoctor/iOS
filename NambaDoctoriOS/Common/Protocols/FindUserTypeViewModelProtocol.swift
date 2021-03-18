//
//  FindUserTypeViewModelProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 03/02/21.
//

import Foundation

protocol FindUserTypeViewModelProtocol {
    func logonUser (phoneNumber: Nd_V1_CustomerPhoneNumber, _ completion : @escaping (_ patientOrDoc:UserLoginStatus?)->())
}
