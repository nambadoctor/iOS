//
//  ServiceProviderCustomerAllergyMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/8/21.
//

import Foundation

class ServiceProviderCustomerAllergyMapper {
    static func localAllergyToGrpc(allergy:ServiceProviderCustomerAllergy) -> Nd_V1_ServiceProviderAllergyMessage {
        return Nd_V1_ServiceProviderAllergyMessage.with {
            $0.allergyID = allergy.AllergyId.toProto
            $0.allergyName = allergy.AllergyName.toProto
            $0.appointmentID = allergy.AppointmentId.toProto
            $0.serviceRequestID = allergy.ServiceRequestId.toProto
        }
    }
    
    static func grpcAllergyToLocal (allergyMessage:Nd_V1_ServiceProviderAllergyMessage) -> ServiceProviderCustomerAllergy {
        return ServiceProviderCustomerAllergy(AllergyId: allergyMessage.allergyID.toString,
                                              AllergyName: allergyMessage.allergyName.toString,
                                              AppointmentId: allergyMessage.appointmentID.toString,
                                              ServiceRequestId: allergyMessage.serviceRequestID.toString)
    }
}
