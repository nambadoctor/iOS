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
            lastModifiedDate: profile.lastModifedDate.toInt64,
            serviceProviderDeviceInfo: DeviceInformationMapper.GrpcToLocal(deviceInfo: profile.serviceProviderDeviceInfo))
    }
    
    func localProfileToGrpc (profile: ServiceProviderProfile) -> Nd_V1_ServiceProviderProfileMessage {
        return Nd_V1_ServiceProviderProfileMessage.with {
            $0.serviceProviderID = profile.serviceProviderID.toProto
            
            if profile.serviceProviderType != nil { $0.serviceProviderType = profile.serviceProviderType!.toProto }
            if profile.firstName != nil { $0.firstName = profile.firstName!.toProto }
            if profile.lastName != nil { $0.lastName = profile.lastName!.toProto }
            if profile.specialties != nil { $0.specialities = profile.specialties!.convert() }
            if profile.gender != nil { $0.gender = profile.gender!.toProto }
            if profile.phoneNumbers != nil { $0.phoneNumbers = ServiceProviderPhoneNumberObjectMapper.localPhoneNumberToGrpc(phoneNumbers: profile.phoneNumbers!) }
            if profile.addresses != nil { $0.addresses = ServiceProviderAddressObjectMapper.localAddressToGrpc(addresses: profile.addresses!) }
            if profile.applicationInfo != nil { $0.applicationInfo = ServiceProviderAppInfoMapper.localAppInfoToGrpc(appInfo: profile.applicationInfo!) }
            if profile.emailAddress != nil { $0.emailAddress = profile.emailAddress!.toProto }
            if profile.languages != nil { $0.languages = profile.languages!.convert() }
            if profile.educations != nil { $0.educations = ServiceProviderEducationMapper.localEducationToGrpc(education: profile.educations!) }
            if profile.experiences != nil { $0.experiences = ServiceProviderWorkExperienceMapper.localWorkToGrpc(work: profile.experiences!) }
            if profile.serviceFee != nil { $0.serviceFee = profile.serviceFee!.toProto }
            if profile.serviceFeeCurrency != nil { $0.serviceFeeCurrency = profile.serviceFeeCurrency!.toProto }
            if profile.followUpServiceFee != nil { $0.followUpServiceFee = profile.followUpServiceFee!.toProto }
            if profile.appointmentDuration != nil { $0.appointmentDuration = profile.appointmentDuration!.toProto }
            if profile.intervalBetweenAppointment != nil { $0.intervalBetweenAppointment = profile.intervalBetweenAppointment!.toProto }
            if profile.status != nil { $0.status = profile.status!.toProto }
            if profile.registrationNumber != nil { $0.registrationNumber = profile.registrationNumber!.toProto }
            if profile.isActive != nil { $0.isActive = profile.isActive!.toProto }
            if profile.createdDate != nil { $0.createdDate = profile.createdDate!.toProto }
            if profile.lastModifiedDate != nil { $0.lastModifedDate = profile.lastModifiedDate!.toProto }
            if profile.serviceProviderDeviceInfo != nil { $0.serviceProviderDeviceInfo = DeviceInformationMapper.LocalToGrpc(deviceInfo: profile.serviceProviderDeviceInfo!) }
        }
    }
}
