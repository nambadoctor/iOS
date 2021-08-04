//
//  ServiceProviderAddressObjectMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderAddressObjectMapper {
    static func grpcAddressToLocal (address:Nd_V1_ServiceProviderAddress) -> ServiceProviderAddress {
        return ServiceProviderAddress(streetAddress: address.streetAddress.toString,
                                      state: address.state.toString,
                                      country: address.country.toString,
                                      pinCode: address.pinCode.toString,
                                      type: address.type.toString,
                                      addressID: address.addressID.toString,
                                      googleMapsAddress: address.googleMapsAddress.toString)
    }
    
    static func grpcAddressToLocal (addresses:[Nd_V1_ServiceProviderAddress]) -> [ServiceProviderAddress] {
        var addressList:[ServiceProviderAddress] = [ServiceProviderAddress]()
        
        for address in addresses {
            addressList.append(grpcAddressToLocal(address: address))
        }
        
        return addressList
    }
    
    static func localAddressToGrpc (address:ServiceProviderAddress) -> Nd_V1_ServiceProviderAddress {
        return Nd_V1_ServiceProviderAddress.with {
            $0.streetAddress = address.streetAddress.toProto
            $0.state = address.state.toProto
            $0.country = address.country.toProto
            $0.pinCode = address.pinCode.toProto
            $0.type = address.type.toProto
            $0.addressID = address.addressID.toProto
            $0.googleMapsAddress = address.googleMapsAddress.toProto
        }
    }
    
    static func localAddressToGrpc (addresses:[ServiceProviderAddress]) -> [Nd_V1_ServiceProviderAddress] {
        var addressList:[Nd_V1_ServiceProviderAddress] = [Nd_V1_ServiceProviderAddress]()
        
        for address in addresses {
            addressList.append(localAddressToGrpc(address: address))
        }
        
        return addressList
    }
}
