//
//  CustomerProfileMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerProfileMapper {
    func grpcCustomerToLocal (customer:Nd_V1_CustomerCustomerProfileMessage) -> CustomerProfile {
        return CustomerProfile(
            customerID: customer.customerID.toString,
            firstName: customer.firstName.toString,
            lastName: customer.lastName.toString,
            gender: customer.gender.toString,
            age: customer.age.toString,
            phoneNumbers: CustomerPhoneNumberMapper.grpcPhoneNumberToLocal(phoneNumberMessages: customer.phoneNumbers),
            addresses: CustomerAddressMapper.grpcAddressToLocal(addresses: customer.addresses),
            appInfo: CustomerAppInfoMapper.grpcAppInfoToLocal(appInfo: customer.appInfo),
            languages: customer.languages.convert(),
            emailAddress: customer.emailAddress.toString,
            activeAppointmentIds: customer.activeAppointmentIds.convert(),
            completedAppointmentIds: customer.completedAppointmentIds.convert(),
            profilePicURL: customer.profilePicURL.toString,
            primaryServiceProviderID: customer.primaryServiceProviderID.toString,
            Allergies: CustomerAllergyMapper.grpcAllergyToLocal(allergies: customer.allergies),
            MedicalHistories: CustomerMedicalHistoryMapper.grpcMedicalHistoryToLocal(medicalHistories: customer.medicalHistories),
            lastModifiedDate: customer.lastModifedDate.toInt64,
            createdDate: customer.createdDate.toInt64)
    }
    
    func grpcCustomerToLocal (customer:[Nd_V1_CustomerCustomerProfileMessage]) -> [CustomerProfile] {
        var customerList:[CustomerProfile] = [CustomerProfile]()
        
        for cus in customer {
            customerList.append(grpcCustomerToLocal(customer: cus))
        }

        return customerList
    }

    func localCustomerToGrpc (customer:CustomerProfile) -> Nd_V1_CustomerCustomerProfileMessage {
        return Nd_V1_CustomerCustomerProfileMessage.with {
            $0.customerID = customer.customerID.toProto
            $0.firstName = customer.firstName.toProto
            $0.lastName = customer.lastName.toProto
            $0.gender = customer.gender.toProto
            $0.age = customer.age.toProto
            $0.phoneNumbers = CustomerPhoneNumberMapper.localPhoneNumberToGrpc(phoneNumbers: customer.phoneNumbers)
            $0.addresses = CustomerAddressMapper.localAddressToGrpc(addresses: customer.addresses)
            $0.appInfo = CustomerAppInfoMapper.localAppInfoToGrpc(appInfo: customer.appInfo)
            $0.languages = customer.languages.convert()
            $0.emailAddress = customer.emailAddress.toProto
            $0.activeAppointmentIds = customer.activeAppointmentIds.convert()
            $0.completedAppointmentIds = customer.completedAppointmentIds.convert()
            $0.profilePicURL = customer.profilePicURL.toProto
            $0.primaryServiceProviderID = customer.primaryServiceProviderID.toProto
            $0.allergies = CustomerAllergyMapper.localAvailabilityToGrpc(allergies: customer.Allergies)
            $0.medicalHistories = CustomerMedicalHistoryMapper.localMedicalHistoryToGrpc(medicalHistories: customer.MedicalHistories)
            $0.lastModifedDate = customer.lastModifiedDate.toProto
            $0.createdDate = customer.createdDate.toProto
        }
    }
}
