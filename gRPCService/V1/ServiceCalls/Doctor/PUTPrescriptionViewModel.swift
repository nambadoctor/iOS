//
//  PutPrescriptionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

class PutPrescriptionViewModel: PutPrescriptionViewModelProtocol {
    
    var prescriptionObjectMapper:ServiceProviderPrescriptionMapper
    
    init (prescriptionObjectMapper:ServiceProviderPrescriptionMapper = ServiceProviderPrescriptionMapper()) {
        self.prescriptionObjectMapper = prescriptionObjectMapper
    }
    
    func writePrescriptionToDB(prescriptionViewModel:ServiceRequestViewModel, _ completion : @escaping ((_ successfull:Bool)->())) {
        
        CommonDefaultModifiers.showLoader()
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let prescriptionClient = Nd_V1_ServiceProviderPrescriptionWorkerV1Client(channel: channel)

        let request = prescriptionObjectMapper.localPrescriptionToGrpc(prescription: prescriptionViewModel.med.prescription)
        
        let makePrescription = prescriptionClient.setPrescription(request, callOptions: callOptions)
        
        do {
            let response = try makePrescription.response.wait()
            print("Prescription Write Client Successfull: \(response.id)")
            CommonDefaultModifiers.hideLoader()
            completion(true)
        } catch {
            print("Prescription Write Client Failed: \(error)")
            completion(false)
        }
    }
}
