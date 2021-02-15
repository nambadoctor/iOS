//
//  DoctorContactInfoMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

class DoctorContactInfoMapper {
    func grpcToLocalDoctorContactInfoObject(doctorContact:Nambadoctor_V1_DoctorsContactInfo) -> DoctorContactInfo {
        
        let docContactInfo = DoctorContactInfo(zipCode: doctorContact.zipCode,
                                               phoneNumber: doctorContact.phoneNumber,
                                               emailID: doctorContact.emailID,
                                               streetAddress: doctorContact.streetAddress)
        
        return docContactInfo
    }
    
    func localDoctorContactInfoToGrpcObject(doctorContact:DoctorContactInfo) -> Nambadoctor_V1_DoctorsContactInfo {
        
        let docContactInfo = Nambadoctor_V1_DoctorsContactInfo.with {
            $0.zipCode = doctorContact.zipCode
            $0.phoneNumber = doctorContact.phoneNumber
            $0.emailID = doctorContact.emailID
            $0.streetAddress = doctorContact.streetAddress
        }
        
        return docContactInfo
    }
    
    func localDocContactInfoListToGrpcList(contactInfoList:[DoctorContactInfo]) -> [Nambadoctor_V1_DoctorsContactInfo] {
        
        var contactInfo = [Nambadoctor_V1_DoctorsContactInfo]()
        
        for contact in contactInfoList {
            contactInfo.append(localDoctorContactInfoToGrpcObject(doctorContact: contact))
        }
        
        return contactInfo
        
    }
    
    func grpcDocContactInfoListToLocalList(contactInfoList:[Nambadoctor_V1_DoctorsContactInfo]) -> [DoctorContactInfo] {
        
        var contactInfo = [DoctorContactInfo]()
        
        for contact in contactInfoList {
            contactInfo.append(grpcToLocalDoctorContactInfoObject(doctorContact: contact))
        }
        
        return contactInfo
    }
}
