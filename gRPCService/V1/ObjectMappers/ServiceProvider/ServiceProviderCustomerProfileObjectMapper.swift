//
//  ServiceProviderCustomerProfileObjectMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderCustomerProfileObjectMapper {
    func grpcCustomerToLocal (customer:Nd_V1_ServiceProviderCustomerProfileMessage) -> ServiceProviderCustomerProfile {
        return ServiceProviderCustomerProfile(
            customerID: customer.customerID.toString,
            firstName: customer.firstName.toString,
            lastName: customer.lastName.toString,
            gender: customer.gender.toString,
            age: customer.age.toString,
            phoneNumbers: ServiceProviderPhoneNumberObjectMapper.grpcPhoneNumberToLocal(phoneNumberMessages: customer.phoneNumbers),
            addresses: ServiceProviderAddressObjectMapper.grpcAddressToLocal(addresses: customer.addresses),
            appInfo: ServiceProviderAppInfoMapper.grpcAppInfoToLocal(appInfo: customer.appInfo),
            languages: customer.languages.convert(),
            emailAddress: customer.emailAddress.toString,
            activeAppointmentIds: customer.activeAppointmentIds.convert(),
            completedAppointmentIds: customer.completedAppointmentIds.convert(),
            profilePicURL: customer.profilePicURL.toString,
            primaryServiceProviderID: customer.primaryServiceProviderID.toString,
            lastModifiedDate: customer.lastModifedDate.toInt64,
            createdDate: customer.createdDate.toInt64)
    }
    
    func grpcCustomerToLocal (customer:[Nd_V1_ServiceProviderCustomerProfileMessage]) -> [ServiceProviderCustomerProfile] {
        var customerList:[ServiceProviderCustomerProfile] = [ServiceProviderCustomerProfile]()
        
        for cus in customer {
            customerList.append(grpcCustomerToLocal(customer: cus))
        }

        return customerList
    }

    func localCustomerToGrpc (customer:ServiceProviderCustomerProfile) -> Nd_V1_ServiceProviderCustomerProfileMessage {
        return Nd_V1_ServiceProviderCustomerProfileMessage.with {
            $0.customerID = customer.customerID.toProto
            $0.firstName = customer.firstName.toProto
            $0.lastName = customer.lastName.toProto
            $0.gender = customer.gender.toProto
            $0.age = customer.age.toProto
            $0.phoneNumbers = ServiceProviderPhoneNumberObjectMapper.localPhoneNumberToGrpc(phoneNumbers: customer.phoneNumbers)
            $0.addresses = ServiceProviderAddressObjectMapper.localAddressToGrpc(addresses: customer.addresses)
            $0.appInfo = ServiceProviderAppInfoMapper.localAppInfoToGrpc(appInfo: customer.appInfo)
            $0.languages = customer.languages.convert()
            $0.emailAddress = customer.emailAddress.toProto
            $0.activeAppointmentIds = customer.activeAppointmentIds.convert()
            $0.completedAppointmentIds = customer.completedAppointmentIds.convert()
            $0.profilePicURL = customer.profilePicURL.toProto
            $0.primaryServiceProviderID = customer.primaryServiceProviderID.toProto
            $0.lastModifedDate = customer.lastModifiedDate.toProto
            $0.createdDate = customer.createdDate.toProto
        }
    }
}
