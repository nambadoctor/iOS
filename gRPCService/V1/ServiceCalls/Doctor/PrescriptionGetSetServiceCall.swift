//
//  PrescriptionGetSetServiceCall.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

class PrescriptionGetSetServiceCall : PrescriptionGetSetServiceCallProtocol {
    
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
        
        do {
            let response = try getPrescriptionObj.response.wait()
            let prescription = prescriptionObjectMapper.grpcPrescriptionToLocal(prescription: response)
            print("PrescriptionClient received: \(response)")
            completion(prescription)
        } catch {
            print("PrescriptionClient failed: \(error)")
        }
    }
    
    func setPrescription(medicineViewModel:MedicineViewModel, _ completion : @escaping ((_ successfull:Bool)->())) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let prescriptionClient = Nd_V1_ServiceProviderPrescriptionWorkerV1Client(channel: channel)

        let request = prescriptionObjectMapper.localPrescriptionToGrpc(prescription: medicineViewModel.prescription!)
        
        let makePrescription = prescriptionClient.setPrescription(request, callOptions: callOptions)
        
        do {
            let response = try makePrescription.response.wait()
            print("Prescription Write Client Successfull: \(response.id)")
            completion(true)
        } catch {
            print("Prescription Write Client Failed: \(error)")
            completion(false)
        }
    }
}
