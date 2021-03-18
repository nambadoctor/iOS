//
//  RetrievePrescriptionForAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

class RetrievePrescriptionForAppointmentViewModel : RetrievePrescriptionForAppointmentProtocol {
    
    var prescriptionObjMapper:ServiceProviderPrescriptionMapper
    
    init(prescriptionObjMapper:ServiceProviderPrescriptionMapper = ServiceProviderPrescriptionMapper()) {
        self.prescriptionObjMapper = prescriptionObjMapper
    }
    
    func getPrescription (appointmentId:String, serviceRequestId:String, customerId:String, _ completion: @escaping ((_ prescription:ServiceProviderPrescription?)->())) {
        
        CommonDefaultModifiers.showLoader()

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
            let prescription = prescriptionObjMapper.grpcPrescriptionToLocal(prescription: response)
            print("PrescriptionClient received: \(response)")
            CommonDefaultModifiers.hideLoader()
            completion(prescription)
        } catch {
            print("PrescriptionClient failed: \(error)")
        }
    }
}
