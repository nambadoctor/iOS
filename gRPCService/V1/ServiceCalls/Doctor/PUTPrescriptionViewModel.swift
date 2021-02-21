//
//  PutPrescriptionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

class PutPrescriptionViewModel: PutPrescriptionViewModelProtocol {
    
    var prescriptionObjectMapper:PrescriptionObjectMapper
    
    init (prescriptionObjectMapper:PrescriptionObjectMapper = PrescriptionObjectMapper()) {
        self.prescriptionObjectMapper = prescriptionObjectMapper
    }
    
    func writePrescriptionToDB(prescriptionViewModel:PrescriptionViewModel, _ completion : @escaping ((_ successfull:Bool)->())) {
        
        CommonDefaultModifiers.showLoader()
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let prescriptionClient = Nambadoctor_V1_PrescriptionWorkerV1Client(channel: channel)

        let request = prescriptionObjectMapper.localPrescriptionToGrpcObject(prescription: prescriptionViewModel.prescription)
        
        print(request)

        let makePrescription = prescriptionClient.saveNewPrescription(request, callOptions: callOptions)
        
        do {
            let response = try makePrescription.response.wait()
            print("Prescription Write Client Successfull: \(response.prescriptionID)")
            CommonDefaultModifiers.hideLoader()
            completion(true)
        } catch {
            print("Prescription Write Client Failed: \(error)")
            completion(false)
        }
    }
}
