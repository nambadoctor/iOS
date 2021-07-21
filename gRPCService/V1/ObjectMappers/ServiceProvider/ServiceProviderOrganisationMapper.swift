//
//  ServiceProviderOrganizationMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/20/21.
//

import Foundation

class ServiceProviderOrganisationMapper {
    static func GrpcToLocal (organization:Nd_V1_ServiceProviderOrganisationMessage) -> ServiceProviderOrganisation {
        return ServiceProviderOrganisation(organisationId: organization.organisationID.toString,
                                           phoneNumbers: ServiceProviderPhoneNumberObjectMapper.grpcPhoneNumberToLocal(phoneNumberMessages: organization.phoneNumbers),
                                           addresses: ServiceProviderAddressObjectMapper.grpcAddressToLocal(addresses: organization.addresses),
                                           organisationTimings: ServiceProviderOrganisationTimingMapper.GrpcToLocal(timings: organization.organisationTimings),
                                           emailAddresses: organization.emailAddresses.convert(),
                                           adImages: organization.adImages.convert(),
                                           specialities: organization.specialities.convert(),
                                           links: organization.links.convert(),
                                           doctorIds: organization.doctorIds.convert(),
                                           secretaryIds: organization.secretaryIds.convert(),
                                           name: organization.name.toString,
                                           description: organization.description_p.toString,
                                           type: organization.type.toString,
                                           createdDate: organization.createdDate.toInt64,
                                           lastModifedDate: organization.lastModifedDate.toInt64,
                                           logo: organization.logo.toString)
    }
    
    static func GrpcToLocal (organization:[Nd_V1_ServiceProviderOrganisationMessage]) -> [ServiceProviderOrganisation] {
        var toReturn = [ServiceProviderOrganisation]()
        
        for org in organization {
            toReturn.append(GrpcToLocal(organization: org))
        }
        
        return toReturn
    }
    
    static func LocalToGrpc (organization:ServiceProviderOrganisation) -> Nd_V1_ServiceProviderOrganisationMessage {
        return Nd_V1_ServiceProviderOrganisationMessage.with {
            $0.organisationID = organization.organisationId.toProto
            $0.phoneNumbers = ServiceProviderPhoneNumberObjectMapper.localPhoneNumberToGrpc(phoneNumbers: organization.phoneNumbers)
            $0.addresses = ServiceProviderAddressObjectMapper.localAddressToGrpc(addresses: organization.addresses)
            $0.organisationTimings = ServiceProviderOrganisationTimingMapper.LocalToGrpc(timings: organization.organisationTimings)
            $0.emailAddresses = organization.emailAddresses.convert()
            $0.adImages = organization.adImages.convert()
            $0.specialities = organization.specialities.convert()
            $0.links = organization.links.convert()
            $0.doctorIds = organization.doctorIds.convert()
            $0.secretaryIds = organization.secretaryIds.convert()
            $0.name = organization.name.toProto
            $0.description_p = organization.description.toProto
            $0.type = organization.type.toProto
            $0.createdDate = organization.createdDate.toProto
            $0.lastModifedDate = organization.lastModifedDate.toProto
            $0.logo = organization.logo.toProto
        }
    }
    
    static func LocalToGrpc (organization:[ServiceProviderOrganisation]) -> [Nd_V1_ServiceProviderOrganisationMessage] {
        var toReturn = [Nd_V1_ServiceProviderOrganisationMessage]()
        
        for org in organization {
            toReturn.append(LocalToGrpc(organization: org))
        }
        
        return toReturn
    }
}
