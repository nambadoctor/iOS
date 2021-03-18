//
//  ServiceProviderPaymentInfoMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderPaymentInfoMapper {
    static func grpcPaymentInfoToLocal(payment:Nd_V1_ServiceProviderPaymentInfoMessage) -> ServiceProviderPaymentInfo {
        return ServiceProviderPaymentInfo(
            serviceProviderID: payment.serviceProviderID.toString,
            appointmentID: payment.appointmentID.toString,
            paidAmmount: payment.paidAmount.toDouble,
            paidDate: payment.paidDate.toInt64,
            paymentGateway: payment.paymentGateway.toString,
            paymentTransactionID: payment.paymentTransactionID.toString,
            paymentTransactionNotes: payment.paymentTransactionNotes.toString,
            customerID: payment.customerID.toString,
            serviceProviderName: payment.serviceProviderName.toString,
            customerName: payment.customerName.toString)
    }
    
    static func localPaymentInfoToGrpc(payment:ServiceProviderPaymentInfo) -> Nd_V1_ServiceProviderPaymentInfoMessage {
        return Nd_V1_ServiceProviderPaymentInfoMessage.with {
            $0.serviceProviderID = payment.serviceProviderID.toProto
            $0.appointmentID = payment.appointmentID.toProto
            $0.paidAmount = payment.paidAmmount.toProto
            $0.paidDate = payment.paidDate.toProto
            $0.paymentGateway = payment.paymentGateway.toProto
            $0.paymentTransactionID = payment.paymentTransactionID.toProto
            $0.paymentTransactionNotes = payment.paymentTransactionNotes.toProto
            $0.customerID = payment.customerID.toProto
            $0.serviceProviderName = payment.serviceProviderName.toProto
            $0.customerName = payment.customerName.toProto
        }
    }
}
