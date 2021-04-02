//
//  ModifyFeeViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/1/21.
//

import Foundation

class ModifyFeeViewModel:ObservableObject {
    @Published var fee:String
    var feeWaived:Bool = false
    var feeModified:Bool = false
    @Published var toggleModify:Bool = false
    
    init(fee:String) {
        self.fee = String(fee)
    }
    
    func modifyFee () {
        feeModified = true
    }
    
    func waiveFee () {
        fee = "0"
        feeWaived = true
    }
}
