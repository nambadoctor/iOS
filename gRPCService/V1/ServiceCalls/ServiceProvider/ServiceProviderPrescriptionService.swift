//
//  PrescriptionGetSetServiceCall.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

class ServiceProviderPrescriptionService : ServiceProviderPrescriptionServiceProtocol {
    
    var prescriptionObjectMapper:ServiceProviderPrescriptionMapper
    
    init (prescriptionObjectMapper:ServiceProviderPrescriptionMapper = ServiceProviderPrescriptionMapper()) {
        self.prescriptionObjectMapper = prescriptionObjectMapper
    }
    
    func getPrescription (appointmentId:String, serviceRequestId:String, customerId:String, _ completion: @escaping ((_ prescription:ServiceProviderPrescription?)->())) {
        

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let prescriptionClient = Nd_V1_ServiceProviderPrescriptionWorkerV1Client(channel: channel)
        
        let request = Nd_V1_ServiceProviderServiceRequestRequestMessage.with {
            $0.appointmentID = appointmentId.toProto
            $0.customerID = customerId.toProto
            $0.serviceRequestID = serviceRequestId.toProto
        }

        let getPrescriptionObj = prescriptionClient.getPrescription(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getPrescriptionObj.response.wait()
                let prescription = self.prescriptionObjectMapper.grpcPrescriptionToLocal(prescription: response)
                print("PrescriptionClient received: \(response)")
                DispatchQueue.main.async {
                    completion(prescription)
                }
            } catch {
                print("PrescriptionClient failed: \(error)")
            }
        }
    }

    func setPrescription(prescription:ServiceProviderPrescription, _ completion : @escaping ((_ successfull:Bool)->())) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let prescriptionClient = Nd_V1_ServiceProviderPrescriptionWorkerV1Client(channel: channel)

        let request = prescriptionObjectMapper.localPrescriptionToGrpc(prescription: prescription)
        
        print("EWKFJNWKFJN \(request)")
        
        let makePrescription = prescriptionClient.setPrescription(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try makePrescription.response.wait()
                print("Prescription Write Client Successfull: \(response.id)")
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                print("Prescription Write Client Failed: \(error)")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    func downloadPrescription(prescriptionID:String, _ completion: @escaping (_ imageData:String?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let prescriptionClient = Nd_V1_ServiceProviderPrescriptionWorkerV1Client(channel: channel)

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
    
    func getPrescriptionPDF(customerId:String, serviceProviderId:String, appointmentId:String, serviceRequestId:String, _ completion: @escaping (_ pdfData:Data?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let prescriptionClient = Nd_V1_ServiceProviderPrescriptionWorkerV1Client(channel: channel)

        let request = Nd_V1_RequestPdf.with {
            $0.appointmentID = appointmentId.toProto
            $0.customerID = customerId.toProto
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
