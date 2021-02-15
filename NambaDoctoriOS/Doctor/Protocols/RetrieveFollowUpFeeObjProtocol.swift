//
//  RetrieveFollowUpFeeObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

protocol RetrieveFollowUpFeeObjProtocol {
    func getNextFee (doctorId:String, patientId:String, _ completion: @escaping ((_ nextFeeObj:FollowUp?)->()))
}
