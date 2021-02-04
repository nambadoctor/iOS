//
//  PutPrescriptionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

class PutPrescriptionViewModel: PutPrescriptionViewModelProtocol {
    func writePrescriptionToDB(prescriptionViewModel:PrescriptionViewModel, _ completion : @escaping ((_ successfull:Bool)->())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let prescriptionClient = Nambadoctor_V1_PrescriptionWorkerV1Client(channel: channel)

        let request = prescriptionViewModel.prescription!

        let makePrescription = prescriptionClient.saveNewPrescription(request)

        do {
            let response = try makePrescription.response.wait()
            print("Prescription Write Client Successfull: \(response.prescriptionID)")
            completion(true)
        } catch {
            print("Prescription Write Client Failed")
            completion(false)
        }
    }
}
