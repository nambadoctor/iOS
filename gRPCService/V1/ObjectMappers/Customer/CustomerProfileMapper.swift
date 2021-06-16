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
            createdDate: customer.createdDate.toInt64,
            children: CustomerChildProfileMapper.GrpcToLocal(children: customer.children),
            customerProviderDeviceInfo: DeviceInformationMapper.GrpcToLocal(deviceInfo: customer.customerDeviceInfo))
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
            
            if customer.firstName != nil { $0.firstName = customer.firstName!.toProto }
            if customer.lastName != nil { $0.lastName = customer.lastName!.toProto }
            if customer.gender != nil { $0.gender = customer.gender!.toProto }
            if customer.age != nil { $0.age = customer.age!.toProto }
            
            if customer.phoneNumbers != nil { $0.phoneNumbers = CustomerPhoneNumberMapper.localPhoneNumberToGrpc(phoneNumbers: customer.phoneNumbers!) }
            if customer.addresses != nil { $0.addresses = CustomerAddressMapper.localAddressToGrpc(addresses: customer.addresses!) }
            if customer.appInfo != nil { $0.appInfo = CustomerAppInfoMapper.localAppInfoToGrpc(appInfo: customer.appInfo!) }
            if customer.languages != nil { $0.languages = customer.languages!.convert() }
            if customer.emailAddress != nil { $0.emailAddress = customer.emailAddress!.toProto }
            if customer.activeAppointmentIds != nil { $0.activeAppointmentIds = customer.activeAppointmentIds!.convert() }
            if customer.completedAppointmentIds != nil { $0.completedAppointmentIds = customer.completedAppointmentIds!.convert() }
            if customer.profilePicURL != nil { $0.profilePicURL = customer.profilePicURL!.toProto }
            if customer.primaryServiceProviderID != nil { $0.primaryServiceProviderID = customer.primaryServiceProviderID!.toProto }
            if customer.Allergies != nil { $0.allergies = CustomerAllergyMapper.localAvailabilityToGrpc(allergies: customer.Allergies!) }
            if customer.MedicalHistories != nil { $0.medicalHistories = CustomerMedicalHistoryMapper.localMedicalHistoryToGrpc(medicalHistories: customer.MedicalHistories!) }
            
            if customer.lastModifiedDate != nil { $0.lastModifedDate = customer.lastModifiedDate!.toProto }
            if customer.createdDate != nil { $0.createdDate = customer.createdDate!.toProto }
            if customer.children != nil { $0.children = CustomerChildProfileMapper.LocalToGrpc(children: customer.children!) }
            if customer.customerProviderDeviceInfo != nil { $0.customerDeviceInfo = DeviceInformationMapper.LocalToGrpc(deviceInfo: customer.customerProviderDeviceInfo!) }
        }
    }
}

