//
//  CustomerAllergyMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerAllergyMapper {
    static func localAllergyToGrpc(allergy:CustomerAllergy) -> Nd_V1_CustomerAllergyMessage {
        return Nd_V1_CustomerAllergyMessage.with {
            $0.allergyID = "".toProto
            $0.allergyName = allergy.AllergyName.toProto
            $0.appointmentID = allergy.AppointmentId.toProto
            $0.serviceRequestID = allergy.ServiceRequestId.toProto
        }
    }
    
    static func grpcAllergyToLocal (allergyMessage:Nd_V1_CustomerAllergyMessage) -> CustomerAllergy {
        return CustomerAllergy(AllergyId: allergyMessage.allergyID.toString,
                                              AllergyName: allergyMessage.allergyName.toString,
                                              AppointmentId: allergyMessage.appointmentID.toString,
                                              ServiceRequestId: allergyMessage.serviceRequestID.toString)
    }

}
