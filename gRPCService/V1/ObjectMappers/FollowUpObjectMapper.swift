//
//  FollowUpObjectMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

class FollowUpObjectMapper {
    func grpcToLocalFollowUpObject(followup:Nambadoctor_V1_FollowUpObject) -> FollowUp {
        let followup = FollowUp(id: followup.id,
                                      patientID: followup.patientID,
                                      doctorID: followup.doctorID,
                                      discountedFee: followup.discountedFee,
                                      nofDays: followup.nofDays,
                                      createdDateTime: followup.createdDateTime,
                                      appointmentID: followup.appointmentID)
        
        return followup
    }
    
    func localFollowUpToGrpcObject(followup:FollowUp) -> Nambadoctor_V1_FollowUpObject {
        let followup = Nambadoctor_V1_FollowUpObject.with {
            $0.patientID = followup.patientID
            $0.doctorID = followup.doctorID
            $0.discountedFee = followup.discountedFee
            $0.nofDays = followup.nofDays
            $0.createdDateTime = followup.createdDateTime
            $0.appointmentID = followup.appointmentID
        }
        
        return followup
    }
}
