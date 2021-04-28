//
//  CustomerAppointmentService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

protocol CustomerAppointmentServiceProtocol {
    func setAppointment (appointment:CustomerAppointment,
                                completion: @escaping (_ aptId:String?)->())
    func getSingleAppointment(appointmentId: String, serviceProviderId: String, _ completion: @escaping ((CustomerAppointment?) -> ()))
    func getCustomerAppointments (customerId:String,
                             completion: @escaping ((_ appointmentList:[CustomerAppointment]?)->()))
    func getAppointmentPayments (appointmentId: String, serviceProviderId: String, _ completion: @escaping (([CustomerPaymentInfo]?) -> ()))
    func setPayment (paymentInfo:CustomerPaymentInfo,
                                completion: @escaping (_ updated:Bool)->())
}

class CustomerAppointmentService : CustomerAppointmentServiceProtocol {
    var customerAppointmentMapper:CustomerAppointmentMapper
    var paymentInfoMapper:CustomerPaymentInfoMapper
    
    init(appointmentMapper:CustomerAppointmentMapper = CustomerAppointmentMapper(),
         paymentInfoMapper:CustomerPaymentInfoMapper = CustomerPaymentInfoMapper()) {
        self.customerAppointmentMapper = appointmentMapper
        self.paymentInfoMapper = paymentInfoMapper
    }
    
    func setAppointment (appointment:CustomerAppointment,
                                completion: @escaping (_ aptId:String?)->()) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
                
        let appointmentClient = Nd_V1_CustomerAppointmentWorkerV1Client(channel: channel)
        
        let request = customerAppointmentMapper.localAppointmentToGrpc(appointment: appointment)
        
        let setAptStatus = appointmentClient.setAppointment(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try setAptStatus.response.wait()
                print("Set Appointment Success for \(response.id)")
                DispatchQueue.main.async {
                    completion(response.id.toString)
                }
            } catch {
                print("Set Appointment \(appointment.appointmentID) Failure")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func getSingleAppointment(appointmentId: String, serviceProviderId: String, _ completion: @escaping ((CustomerAppointment?) -> ())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let appointmentClient = Nd_V1_CustomerAppointmentWorkerV1Client(channel: channel)
        
        let request = Nd_V1_CustomerAppointmentRequestMessage.with {
            $0.serviceProviderID = serviceProviderId.toProto
            $0.appointmentID = appointmentId.toProto
        }

        let getDoctorsAppointment = appointmentClient.getAppointment(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getDoctorsAppointment.response.wait()
                let appointment = self.customerAppointmentMapper.grpcAppointmentToLocal(appointment: response)
                print("Doctor Appointment Client Success \(appointment)")
                DispatchQueue.main.async {
                    completion(appointment)
                }
            } catch {
                print("Doctor Appointment Client Failed")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    func getCustomerAppointments (customerId:String,
                             completion: @escaping ((_ appointmentList:[CustomerAppointment]?)->())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let appointmentClient = Nd_V1_CustomerAppointmentWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = customerId.toProto
        }

        let getDoctorsAppointment = appointmentClient.getAppointments(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getDoctorsAppointment.response.wait()
                let appointmentList = self.customerAppointmentMapper.grpcAppointmentToLocal(appointment: response.appointments)
                print("Customer Appointment Client Success \(appointmentList.count)")
                DispatchQueue.main.async {
                    completion(appointmentList)
                }
            } catch {
                print("Customer Appointment Client Failed")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func getAppointmentPayments (appointmentId: String, serviceProviderId: String, _ completion: @escaping (([CustomerPaymentInfo]?) -> ())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let appointmentClient = Nd_V1_CustomerAppointmentWorkerV1Client(channel: channel)
        
        let request = Nd_V1_CustomerAppointmentRequestMessage.with {
            $0.serviceProviderID = serviceProviderId.toProto
            $0.appointmentID = appointmentId.toProto
        }

        let getAppointmentPaymentsClient = appointmentClient.getAppointmentPayments(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getAppointmentPaymentsClient.response.wait()
                let paymentList = self.paymentInfoMapper.grpcPaymentInfoToLocal(paymentMessages: response.payments)
                print("Customer Payment List Client Success \(paymentList.count)")
                DispatchQueue.main.async {
                    completion(paymentList)
                }
            } catch {
                print("Customer Payment List Client Failed")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func setPayment (paymentInfo:CustomerPaymentInfo,
                                completion: @escaping (_ updated:Bool)->()) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
                
        let appointmentClient = Nd_V1_CustomerAppointmentWorkerV1Client(channel: channel)
        
        let request = paymentInfoMapper.localPaymentInfoToGrpc(payment: paymentInfo)
        
        let setAptStatus = appointmentClient.setNewPayment(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try setAptStatus.response.wait()
                print("Set Payment Success for \(response.id)")
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                print("Set Payment \(paymentInfo.appointmentID) Failure")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
}
