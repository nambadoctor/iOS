//
//  CustomerAppointmentService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

class CustomerAppointmentService {
    var customerAppointmentMapper:CustomerAppointmentMapper
    
    init(appointmentMapper:CustomerAppointmentMapper = CustomerAppointmentMapper()) {
        self.customerAppointmentMapper = appointmentMapper
    }
    
    func setAppointment (appointment:CustomerAppointment,
                                completion: @escaping (_ updated:Bool)->()) {
                
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
                    completion(true)
                }
            } catch {
                print("Set Appointment \(appointment.appointmentID) Failure")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    func getSingleAppointment(appointmentId: String, serviceProviderId: String, _ completion: @escaping ((CustomerAppointment?) -> ())) {
        let stopwatch = StopwatchManager(callingClass: "SERVICE_PROVIDER_GET_APPOINTMENT")
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
                stopwatch.start()
                let response = try getDoctorsAppointment.response.wait()
                stopwatch.stop()
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
  
}
