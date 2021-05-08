//
//  CustomerPrescriptionService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

protocol CustomerPrescriptionServiceProtocol {
    func getPrescription(appointmentId:String, serviceRequestId:String, completion: @escaping (_ prescription:CustomerPrescription?)->())
    func downloadPrescription(prescriptionID:String, _ completion: @escaping (_ imageData:String?)->())
    func getPrescriptionPDF(serviceProviderId:String, appointmentId:String, serviceRequestId:String, _ completion: @escaping (_ pdfData:Data?)->())
}

class CustomerPrescriptionService {
    var prescriptionMapper:CustomerPrescriptionMapper = CustomerPrescriptionMapper()
    
    func getPrescription(appointmentId:String, serviceRequestId:String, completion: @escaping (_ prescription:CustomerPrescription?)->()) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let prescriptionClient = Nd_V1_CustomerPrescriptionWorkerV1Client(channel: channel)
        
        let request = Nd_V1_CustomerServiceRequestRequestMessage.with {
            $0.appointmentID = appointmentId.toProto
            $0.customerID = UserIdHelper().retrieveUserId().toProto
            $0.serviceRequestID = serviceRequestId.toProto
        }
        
        let getPrescription = prescriptionClient.getPrescription(request,callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getPrescription.response.wait()
                let prescription = self.prescriptionMapper.grpcPrescriptionToLocal(prescription: response)
                print("Get prescription Success \(response.prescriptionID)")
                DispatchQueue.main.async {
                    completion(prescription)
                }
            } catch {
                print("Get prescription FAILED \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func downloadPrescription(prescriptionID:String, _ completion: @escaping (_ imageData:String?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let prescriptionClient = Nd_V1_CustomerPrescriptionWorkerV1Client(channel: channel)

        let request = Nd_V1_IdMessage.with {
            $0.id = prescriptionID.toProto
        }
        
        let downloadPrescription = prescriptionClient.downloadPrescriptionMedia(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try downloadPrescription.response.wait()
                print("Prescription Download Client Successfull: \(response.message)")
                DispatchQueue.main.async {
                    if response.message.toString.isEmpty {
                        completion(nil)
                    } else {
                        completion(response.message.toString)
                    }
                }
            } catch {
                print("Prescription Download Client Failed: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func getPrescriptionPDF(serviceProviderId:String, appointmentId:String, serviceRequestId:String, _ completion: @escaping (_ pdfData:Data?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let prescriptionClient = Nd_V1_CustomerPrescriptionWorkerV1Client(channel: channel)

        let request = Nd_V1_RequestPdf.with {
            $0.appointmentID = appointmentId.toProto
            $0.customerID = UserIdHelper().retrieveUserId().toProto
            $0.serviceProviderID = serviceProviderId.toProto
            $0.serviceRequestID = serviceRequestId.toProto
        }
        
        let downloadPrescription = prescriptionClient.getPrescriptionPdf(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try downloadPrescription.response.wait()
                print("PrescriptionPDF Download Client Successfull")
                DispatchQueue.main.async {
                    if response.mediaFile != nil {
                        completion(response.mediaFile.value)
                    }
                }
            } catch {
                print("PrescriptionPDF Download Client Failed: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
