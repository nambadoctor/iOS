//
//  CustomerServiceProviderProfileMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerServiceProviderProfileMapper {
    func grpcProfileToLocal (profile:Nd_V1_CustomersServiceProviderProfileMessage) -> CustomerServiceProviderProfile {
        return CustomerServiceProviderProfile(
            serviceProviderID: profile.serviceProviderID.toString,
            serviceProviderType: profile.serviceProviderType.toString,
            firstName: profile.firstName.toString,
            lastName: profile.lastName.toString,
            specialties: profile.specialities.convert(),
            gender: profile.gender.toString,
            addresses: CustomerAddressMapper.grpcAddressToLocal(addresses: profile.addresses),
            applicationInfo: CustomerAppInfoMapper.grpcAppInfoToLocal(appInfo: profile.applicationInfo),
            emailAddress: profile.emailAddress.toString,
            profilePictureURL: profile.profilePictureURL.toString,
            languages: profile.languages.convert(),
            educations: CustomerEducationMapper.grpcEducationToLocal(education: profile.educations),
            experiences: CustomerWorkExperienceMapper.grpcWorkToLocal(work: profile.experiences),
            serviceFee: profile.serviceFee.toDouble,
            serviceFeeCurrency: profile.serviceFeeCurrency.toString,
            followUpServiceFee: profile.followUpServiceFee.toDouble,
            appointmentDuration: profile.appointmentDuration.toInt32,
            intervalBetweenAppointment: profile.intervalBetweenAppointment.toInt32,
            status: profile.status.toString,
            registrationNumber: profile.registrationNumber.toString,
            isActive: profile.isActive.toBool,
            createdDate: profile.createdDate.toInt64,
            LatestSlotStartTime: profile.latestSlotEndTime.toInt64,
            lastModifiedDate: profile.lastModifedDate.toInt64,
            additionalInfo: CustomerServiceProviderAdditionalInfoMapper.grpcToLocal(additionalInfo: profile.additionalInfo),
            organisationIds: profile.organisationIds.convert())
    }
    
    func grpcPhoneNumberToLocal (profiles:[Nd_V1_CustomersServiceProviderProfileMessage]) -> [CustomerServiceProviderProfile] {
        var profileList:[CustomerServiceProviderProfile] = [CustomerServiceProviderProfile]()

        for profile in profiles {
            profileList.append(grpcProfileToLocal(profile: profile))
        }

        return profileList
    }
    
    func localProfileToGrpc (profile: CustomerServiceProviderProfile) -> Nd_V1_CustomersServiceProviderProfileMessage {
        return Nd_V1_CustomersServiceProviderProfileMessage.with {
            $0.serviceProviderID = profile.serviceProviderID.toProto
            $0.serviceProviderType = profile.serviceProviderType.toProto
            $0.firstName = profile.firstName.toProto
            $0.lastName = profile.lastName.toProto
            $0.specialities = profile.specialties.convert()
            $0.gender = profile.gender.toProto
            $0.addresses = CustomerAddressMapper.localAddressToGrpc(addresses: profile.addresses)
            $0.applicationInfo = CustomerAppInfoMapper.localAppInfoToGrpc(appInfo: profile.applicationInfo)
            $0.emailAddress = profile.emailAddress.toProto
            $0.profilePictureURL = profile.profilePictureURL.toProto
            $0.languages = profile.languages.convert()
            $0.educations = CustomerEducationMapper.localEducationToGrpc(education: profile.educations)
            $0.experiences = CustomerWorkExperienceMapper.localWorkToGrpc(work: profile.experiences)
            $0.serviceFee = profile.serviceFee.toProto
            $0.serviceFeeCurrency = profile.serviceFeeCurrency.toProto
            $0.followUpServiceFee = profile.followUpServiceFee.toProto
            $0.appointmentDuration = profile.appointmentDuration.toProto
            $0.intervalBetweenAppointment = profile.intervalBetweenAppointment.toProto
            $0.status = profile.status.toProto
            $0.registrationNumber = profile.registrationNumber.toProto
            $0.isActive = profile.isActive.toProto
            $0.createdDate = profile.createdDate.toProto
            $0.lastModifedDate = profile.lastModifiedDate.toProto
            $0.additionalInfo = CustomerServiceProviderAdditionalInfoMapper.localToGrpc(additionalInfo: profile.additionalInfo)
            $0.organisationIds = profile.organisationIds.convert()
        }
    }
}
