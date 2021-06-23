//
//  ServiceProviderSearchableIndexMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/20/21.
//

import Foundation

class ServiceProviderAdditionalInfoMapper {
    static func grpcToLocal (additionalInfo:Nd_V1_ServiceProviderAdditionalInfoMessage) -> ServiceProviderAdditionalInfo {
        return ServiceProviderAdditionalInfo(Symptoms: additionalInfo.symptoms.convert(),
                                             Designation: additionalInfo.designations.convert(),
                                             Specialties: additionalInfo.specialties.convert(),
                                             Categories: additionalInfo.categories.convert(),
                                             Certifications: additionalInfo.certifications.convert(),
                                             ClubMemberships: additionalInfo.clubMemberships.convert(),
                                             Procedures: additionalInfo.procedures.convert(),
                                             Published: additionalInfo.published.convert(),
                                             Links: additionalInfo.links.convert(),
                                             Description: additionalInfo.description_p.toString)
    }
    
    static func localToGrpc (additionalInfo:ServiceProviderAdditionalInfo) -> Nd_V1_ServiceProviderAdditionalInfoMessage {
        return Nd_V1_ServiceProviderAdditionalInfoMessage.with {
            $0.symptoms = additionalInfo.Symptoms.convert()
            $0.designations = additionalInfo.Designation.convert()
            $0.specialties = additionalInfo.Specialties.convert()
            $0.categories = additionalInfo.Categories.convert()
            $0.certifications = additionalInfo.Certifications.convert()
            $0.clubMemberships = additionalInfo.ClubMemberships.convert()
            $0.procedures = additionalInfo.Procedures.convert()
            $0.published = additionalInfo.Published.convert()
            $0.links = additionalInfo.Links.convert()
            $0.description_p = additionalInfo.Description.toProto
        }
    }
}
