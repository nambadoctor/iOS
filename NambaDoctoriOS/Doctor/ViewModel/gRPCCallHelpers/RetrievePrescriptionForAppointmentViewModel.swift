//
//  RetrievePrescriptionForAppointment.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class RetrievePrescriptionForAppointmentViewModel : RetrievePrescriptionForAppointmentProtocol {
    
    var prescriptionObjMapper:PrescriptionObjectMapper
    
    init(prescriptionObjMapper:PrescriptionObjectMapper = PrescriptionObjectMapper()) {
        self.prescriptionObjMapper = prescriptionObjMapper
    }
    
    func getPrescription (appointmentId:String, _ completion: @escaping ((_ prescription:Prescription?)->())) {
        
        CommonDefaultModifiers.showLoader()

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let prescriptionClient = Nambadoctor_V1_PrescriptionWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_PrescriptionRequest.with {
            $0.appointmentID = appointmentId
        }

        let getPrescriptionObj = prescriptionClient.getPrescriptionOfAppointment(request, callOptions: callOptions)
        
        do {
            let response = try getPrescriptionObj.response.wait()
            let prescription = prescriptionObjMapper.grpcToLocalPrescriptionObject(prescription: response)
            print("PrescriptionClient received: \(response)")
            CommonDefaultModifiers.hideLoader()
            completion(prescription)
        } catch {
            print("PrescriptionClient failed: \(error)")
        }
    }
}
