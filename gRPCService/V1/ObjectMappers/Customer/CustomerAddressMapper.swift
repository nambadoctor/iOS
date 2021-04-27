//
//  CustomerAddressMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerAddressMapper {
    static func grpcAddressToLocal (address:Nd_V1_CustomerAddress) -> CustomerAddress {
        return CustomerAddress(streetAddress: address.streetAddress.toString,
                                      state: address.state.toString,
                                      country: address.country.toString,
                                      pinCode: address.pinCode.toString,
                                      type: address.type.toString,
                                      addressID: address.addressID.toString)
    }
    
    static func grpcAddressToLocal (addresses:[Nd_V1_CustomerAddress]) -> [CustomerAddress] {
        var addressList:[CustomerAddress] = [CustomerAddress]()
        
        for address in addresses {
            addressList.append(grpcAddressToLocal(address: address))
        }
        
        return addressList
    }

    static func localAddressToGrpc (address:CustomerAddress) -> Nd_V1_CustomerAddress {
        return Nd_V1_CustomerAddress.with {
            $0.streetAddress = address.streetAddress.toProto
            $0.state = address.state.toProto
            $0.country = address.country.toProto
            $0.pinCode = address.pinCode.toProto
            $0.type = address.type.toProto
            $0.addressID = address.addressID.toProto
        }
    }
    
    static func localAddressToGrpc (addresses:[CustomerAddress]) -> [Nd_V1_CustomerAddress] {
        var addressList:[Nd_V1_CustomerAddress] = [Nd_V1_CustomerAddress]()
        
        for address in addresses {
            addressList.append(localAddressToGrpc(address: address))
        }
        
        return addressList
    }

}
