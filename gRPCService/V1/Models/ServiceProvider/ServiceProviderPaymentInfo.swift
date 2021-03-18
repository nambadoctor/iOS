//
//  ServiceProviderPaymentInfo.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

struct ServiceProviderPaymentInfo {
    var serviceProviderID:String
    var appointmentID:String
    var paidAmmount:Double
    var paidDate:Int64
    var paymentGateway:String
    var paymentTransactionID:String
    var paymentTransactionNotes:String
    var customerID:String
    var serviceProviderName:String
    var customerName:String
}
