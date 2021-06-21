//
//  CustomerServiceProviderSearchableIndexMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/20/21.
//

import Foundation

class CustomerServiceProviderSearchableIndexMapper {
    static func grpcToLocal (searchableIndex:Nd_V1_CustomerServiceProviderSearchableIndexMessage) -> CustomerServiceProviderSearchableIndexes {
        return CustomerServiceProviderSearchableIndexes(Symptoms: searchableIndex.symptoms.convert(),
                                                        Designation: searchableIndex.designations.convert(),
                                                        Specialties: searchableIndex.specialties.convert())
    }
    
    static func localToGrpc (searchableIndex:CustomerServiceProviderSearchableIndexes) -> Nd_V1_CustomerServiceProviderSearchableIndexMessage {
        return Nd_V1_CustomerServiceProviderSearchableIndexMessage.with {
            $0.symptoms = searchableIndex.Symptoms.convert()
            $0.designations = searchableIndex.Designation.convert()
            $0.specialties = searchableIndex.Specialties.convert()
        }
    }
}
