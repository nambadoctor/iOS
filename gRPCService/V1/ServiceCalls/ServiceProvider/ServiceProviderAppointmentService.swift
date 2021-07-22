//
//  AppointmentGetSetServiceCall.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

protocol ServiceProviderAppointmentServiceProtocol {
    func getDocAppointments (serviceProviderId:String, completion: @escaping ((_ appointmentList:[ServiceProviderAppointment]?)->()))
    
    func getCustomerAppointmentList(patientId: String, _ completion: @escaping (([ServiceProviderAppointment]?) -> ()))
    
    func setAppointment (appointment:ServiceProviderAppointment,
                                completion: @escaping (_ updated:Bool)->())
    
    func getSingleAppointment (appointmentId:String, serviceProviderId:String, _ completion: @escaping ((ServiceProviderAppointment?) -> ()))
    
    func getOrganisationAppointments (serviceProviderId:String,
                             completion: @escaping ((_ appointmentList:[ServiceProviderAppointment]?)->()))
}

class ServiceProviderAppointmentService : ServiceProviderAppointmentServiceProtocol {
    
    var appointmentObjectMapper:ServiceProviderAppointmentObjectMapper
        
    init(appointmentObjMapper:ServiceProviderAppointmentObjectMapper = ServiceProviderAppointmentObjectMapper()) {
        self.appointmentObjectMapper = appointmentObjMapper
    }
    
    func getDocAppointments (serviceProviderId:String,
                             completion: @escaping ((_ appointmentList:[ServiceProviderAppointment]?)->())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let appointmentClient = Nd_V1_ServiceProviderAppointmentWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = serviceProviderId.toProto
        }

        let getDoctorsAppointment = appointmentClient.getAppointments(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getDoctorsAppointment.response.wait()
                var appointmentList = self.appointmentObjectMapper.grpcAppointmentToLocal(appointment: response.appointments)
                print("Doctor Appointment Client Success \(appointmentList.count)")
                DispatchQueue.main.async {
                    completion(appointmentList)
                }
            } catch {
                print("Doctor Appointment Client Failed")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func getCustomerAppointmentList(patientId: String, _ completion: @escaping (([ServiceProviderAppointment]?) -> ())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let appointmentsClient = Nd_V1_ServiceProviderAppointmentWorkerV1Client(channel: channel)
        
        let request = Nd_V1_ServiceProviderCustomerAppointmentsRequestMessage.with {
            $0.customerID = patientId.toProto
            $0.serviceProviderID = UserIdHelper().retrieveUserId().toProto
        }
        
        let getPatientAppointments = appointmentsClient.getCustomerAppointments(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getPatientAppointments.response.wait()
                let appointmentList = self.appointmentObjectMapper.grpcAppointmentToLocal(appointment: response.appointments)
                print("Patient Appointments received")
                DispatchQueue.main.async {
                    completion(appointmentList)
                }
            } catch {
                print("Patient Appointments failed: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    
    func setAppointment (appointment:ServiceProviderAppointment,
                                completion: @escaping (_ updated:Bool)->()) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
                
        let appointmentClient = Nd_V1_ServiceProviderAppointmentWorkerV1Client(channel: channel)
        
        let request = appointmentObjectMapper.localAppointmentToGrpc(appointment: appointment)
        
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
    
    func getSingleAppointment(appointmentId: String, serviceProviderId: String, _ completion: @escaping ((ServiceProviderAppointment?) -> ())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let appointmentClient = Nd_V1_ServiceProviderAppointmentWorkerV1Client(channel: channel)
        
        let request = Nd_V1_ServiceProviderAppointmentRequestMessage.with {
            $0.serviceProviderID = serviceProviderId.toProto
            $0.appointmentID = appointmentId.toProto
        }

        let getDoctorsAppointment = appointmentClient.getAppointment(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try getDoctorsAppointment.response.wait()
                var appointment = self.appointmentObjectMapper.grpcAppointmentToLocal(appointment: response)
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
    
    func getOrganisationAppointments (serviceProviderId:String,
                             completion: @escaping ((_ appointmentList:[ServiceProviderAppointment]?)->())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let appointmentClient = Nd_V1_ServiceProviderAppointmentWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = serviceProviderId.toProto
        }

        let getDoctorsAppointment = appointmentClient.getOrganisationAppointments(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getDoctorsAppointment.response.wait()
                var appointmentList = self.appointmentObjectMapper.grpcAppointmentToLocal(appointment: response.appointments)
                print("Doctor Organization Appointment Client Success \(appointmentList.count)")
                DispatchQueue.main.async {
                    completion(appointmentList)
                }
            } catch {
                print("Doctor Organization Appointment Client Failed")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    
}
