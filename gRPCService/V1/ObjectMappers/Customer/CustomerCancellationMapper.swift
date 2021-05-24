//
//  CustomerCancellationMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/23/21.
//

import Foundation

class CustomerCancellationMapper {
    static func grpcCancellationToLocal (cancellation:Nd_V1_CustomerCancellationMessage) -> CustomerCancellation {
        return CustomerCancellation(ReasonName: cancellation.reasonName.toString,
                                           CancelledTime: cancellation.cancelledTime.toInt64,
                                           CancelledBy: cancellation.cancelledBy.toString,
                                           CancelledByType: cancellation.cancelledByType.toString,
                                           Notes: cancellation.notes.toString)
    }

    static func localCancellationToGrpc (cancellation:CustomerCancellation) -> Nd_V1_CustomerCancellationMessage {
        return Nd_V1_CustomerCancellationMessage.with {
            $0.reasonName = cancellation.ReasonName.toProto
            $0.cancelledTime = cancellation.CancelledTime.toProto
            $0.cancelledBy = cancellation.CancelledBy.toProto
            $0.cancelledByType = cancellation.CancelledByType.toProto
            $0.notes = cancellation.Notes.toProto
        }
    }

}
