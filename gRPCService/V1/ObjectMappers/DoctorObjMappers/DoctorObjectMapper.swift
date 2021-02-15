//
//  DoctorObjectMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

class DoctorObjectMapper {
    
    var contactInfoMapper:DoctorContactInfoMapper
    var educationInfoMapper:DoctorEducationMapper
    var experiencemapper:DoctorExperienceMapper
    var latestSlotMapper:DoctorLatestSlotMapper
    
    init(contactInfoMapper:DoctorContactInfoMapper = DoctorContactInfoMapper(),
         educationInfoMapper:DoctorEducationMapper = DoctorEducationMapper(),
         experienceMapper:DoctorExperienceMapper = DoctorExperienceMapper(),
         latestSlotMapper:DoctorLatestSlotMapper = DoctorLatestSlotMapper()) {
        self.contactInfoMapper = contactInfoMapper
        self.educationInfoMapper = educationInfoMapper
        self.experiencemapper = experienceMapper
        self.latestSlotMapper = latestSlotMapper
    }
    
    func grpcToLocalDoctorObject(doctor:Nambadoctor_V1_DoctorResponse) -> Doctor {
        
        let contactInfo = contactInfoMapper.grpcDocContactInfoListToLocalList(contactInfoList: doctor.contactInfos)
        
        let educationInfo = educationInfoMapper.grpcDocEducationListToLocalList(educationList: doctor.educationInfos)
        
        let experiences = experiencemapper.grpcDocExperienceListToLocalList(experienceList: doctor.experiences)
        
        let latestSlot = latestSlotMapper.grpcToLocalDoctorLatestSlotObject(latestSlot: doctor.latestSlot)
        
        let docObj = Doctor(DoctorId: doctor.doctorID,
                            FullName: doctor.fullName,
                            LoginPhoneNumber: doctor.loginPhoneNumber,
                            ProfilePic: doctor.profilePic,
                            CreatedDateTime: doctor.createdDateTime,
                            ConsultationFee: doctor.consultationFee,
                            RegistrationNumber: doctor.registrationNumber,
                            Specialities: doctor.specialities,
                            Languages: doctor.languages,
                            DeviceTokenId: doctor.deviceTokenID,
                            DoctorsContactInfo: contactInfo,
                            DoctorsEducationInfo: educationInfo,
                            DoctorsExperience: experiences,
                            latestSlot: latestSlot)
        
        return docObj
    }

    func localDoctorToGrpcObject(doctor:Doctor) -> Nambadoctor_V1_DoctorResponse {
        
        let contactInfo = contactInfoMapper.localDocContactInfoListToGrpcList(contactInfoList: doctor.doctorsContactInfo)
        
        let educationInfo = educationInfoMapper.localDocEducationListToGrpcList(educationList: doctor.doctorsEducationInfo)
        
        let experiences = experiencemapper.localDocExperienceListToGrpcList(experienceList: doctor.doctorsExperience)
        
        let latestSlot = latestSlotMapper.localDoctorLatestSlotToGrpcObject(latestSlot: doctor.latestSlot)
        
        let docObj = Nambadoctor_V1_DoctorResponse.with {
            $0.doctorID = doctor.doctorID
            $0.fullName = doctor.fullName
            $0.loginPhoneNumber = doctor.loginPhoneNumber
            $0.profilePic = doctor.profilePic
            $0.createdDateTime = doctor.createdDateTime
            $0.consultationFee = doctor.consultationFee
            $0.registrationNumber = doctor.registrationNumber
            $0.specialities = doctor.specialities
            $0.languages = doctor.languages
            $0.deviceTokenID = doctor.deviceTokenID
            $0.contactInfos = contactInfo
            $0.educationInfos = educationInfo
            $0.experiences = experiences
            $0.latestSlot = latestSlot
        }
        
        return docObj
    }
}
