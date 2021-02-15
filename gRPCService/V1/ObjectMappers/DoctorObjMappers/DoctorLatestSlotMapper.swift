//
//  DoctorLatestSlotMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

class DoctorLatestSlotMapper {
    func grpcToLocalDoctorLatestSlotObject(latestSlot:Nambadoctor_V1_LatestSlot) -> LatestSlot {
        let slot = LatestSlot(id: latestSlot.id,
                              doctorID: latestSlot.doctorID,
                              bookedBy: latestSlot.bookedBy,
                              duration: latestSlot.duration,
                              startDateTime: latestSlot.startDateTime,
                              status: latestSlot.status,
                              createdDateTime: latestSlot.createdDateTime)
        
        return slot
    }
    
    func localDoctorLatestSlotToGrpcObject(latestSlot:LatestSlot) -> Nambadoctor_V1_LatestSlot {
        let slot = Nambadoctor_V1_LatestSlot.with {
            $0.id = latestSlot.id
            $0.doctorID = latestSlot.doctorID
            $0.bookedBy = latestSlot.bookedBy
            $0.duration = latestSlot.duration
            $0.startDateTime = latestSlot.startDateTime
            $0.status = latestSlot.status
            $0.createdDateTime = latestSlot.createdDateTime
        }
        
        return slot
    }
}
