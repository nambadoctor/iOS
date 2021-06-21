//
//  ServiceProviderSearchableIndexMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/20/21.
//

import Foundation

class ServiceProviderSearchableIndexMapper {
    static func grpcToLocal (searchableIndex:Nd_V1_ServiceProviderSearchableIndexMessage) -> ServiceProviderSearchableIndexes {
        return ServiceProviderSearchableIndexes(Symptoms: searchableIndex.symptoms.convert(),
                                                        Designation: searchableIndex.designations.convert(),
                                                        Specialties: searchableIndex.specialties.convert())
    }
    
    static func localToGrpc (searchableIndex:ServiceProviderSearchableIndexes) -> Nd_V1_ServiceProviderSearchableIndexMessage {
        return Nd_V1_ServiceProviderSearchableIndexMessage.with {
            $0.symptoms = searchableIndex.Symptoms.convert()
            $0.designations = searchableIndex.Designation.convert()
            $0.specialties = searchableIndex.Specialties.convert()
        }
    }
}
