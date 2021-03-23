//
//  ServiceProviderProfileMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderProfileMapper {
    func grpcProfileToLocal (profile:Nd_V1_ServiceProviderProfileMessage) -> ServiceProviderProfile {
        return ServiceProviderProfile(
            serviceProviderID: profile.serviceProviderID.toString,
            serviceProviderType: profile.serviceProviderType.toString,
            firstName: profile.firstName.toString,
            lastName: profile.lastName.toString,
            specialties: profile.specialities.convert(),
            gender: profile.gender.toString,
            phoneNumbers: ServiceProviderPhoneNumberObjectMapper.grpcPhoneNumberToLocal(phoneNumberMessages: profile.phoneNumbers),
            addresses: ServiceProviderAddressObjectMapper.grpcAddressToLocal(addresses: profile.addresses),
            applicationInfo: ServiceProviderAppInfoMapper.grpcAppInfoToLocal(appInfo: profile.applicationInfo),
            emailAddress: profile.emailAddress.toString,
            profilePictureURL: profile.profilePictureURL.toString,
            languages: profile.languages.convert(),
            educations: ServiceProviderEducationMapper.grpcEducationToLocal(education: profile.educations),
            experiences: ServiceProviderWorkExperienceMapper.grpcWorkToLocal(work: profile.experiences),
            serviceFee: profile.serviceFee.toDouble,
            serviceFeeCurrency: profile.serviceFeeCurrency.toString,
            followUpServiceFee: profile.followUpServiceFee.toDouble,
            appointmentDuration: profile.appointmentDuration.toInt32,
            intervalBetweenAppointment: profile.intervalBetweenAppointment.toInt32,
            status: profile.status.toString,
            registrationNumber: profile.registrationNumber.toString,
            isActive: profile.isActive.toBool,
            createdDate: profile.createdDate.toInt64,
            lastModifiedDate: profile.lastModifedDate.toInt64)
    }
    
    func localProfileToGrpc (profile: ServiceProviderProfile) -> Nd_V1_ServiceProviderProfileMessage {
        return Nd_V1_ServiceProviderProfileMessage.with {
            $0.serviceProviderID = profile.serviceProviderID.toProto
            $0.serviceProviderType = profile.serviceProviderType.toProto
            $0.firstName = profile.firstName.toProto
            $0.lastName = profile.lastName.toProto
            $0.specialities = profile.specialties.convert()
            $0.gender = profile.gender.toProto
            $0.phoneNumbers = ServiceProviderPhoneNumberObjectMapper.localPhoneNumberToGrpc(phoneNumbers: profile.phoneNumbers)
            $0.addresses = ServiceProviderAddressObjectMapper.localAddressToGrpc(addresses: profile.addresses)
            $0.applicationInfo = ServiceProviderAppInfoMapper.localAppInfoToGrpc(appInfo: profile.applicationInfo)
            $0.emailAddress = profile.emailAddress.toProto
            $0.profilePictureURL = profile.profilePictureURL.toProto
            $0.languages = profile.languages.convert()
            $0.educations = ServiceProviderEducationMapper.localEducationToGrpc(education: profile.educations)
            $0.experiences = ServiceProviderWorkExperienceMapper.localWorkToGrpc(work: profile.experiences)
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
        }
    }
}
