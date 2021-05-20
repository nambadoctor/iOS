//
//  ServiceProviderCancellationMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/19/21.
//

import Foundation

class ServiceProviderCancellationMapper {
    static func grpcCancellationToLocal (cancellation:Nd_V1_ServiceProviderCancellationMessage) -> ServiceProviderCancellation {
        return ServiceProviderCancellation(ReasonName: cancellation.reasonName.toString,
                                           CancelledTime: cancellation.cancelledTime.toInt64,
                                           CancelledBy: cancellation.cancelledBy.toString,
                                           CancelledByType: cancellation.cancelledByType.toString,
                                           Notes: cancellation.notes.toString)
    }

    static func localCancellationToGrpc (cancellation:ServiceProviderCancellation) -> Nd_V1_ServiceProviderCancellationMessage {
        return Nd_V1_ServiceProviderCancellationMessage.with {
            $0.reasonName = cancellation.ReasonName.toProto
            $0.cancelledTime = cancellation.CancelledTime.toProto
            $0.cancelledBy = cancellation.CancelledBy.toProto
            $0.cancelledByType = cancellation.CancelledByType.toProto
            $0.notes = cancellation.Notes.toProto
        }
    }

}
