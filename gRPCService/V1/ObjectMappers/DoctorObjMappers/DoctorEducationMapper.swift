//
//  DoctorEducationMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

class DoctorEducationMapper {
    func grpcToLocalDoctorEducationObject(doctorEducation:Nambadoctor_V1_DoctorsEducationInfo) -> DoctorEducationInfo {
        
        let docEducation = DoctorEducationInfo(collegeName: doctorEducation.collegeName,
                                               course: doctorEducation.course,
                                               yearPassed: doctorEducation.yearPassed)
        
        return docEducation
    }
    
    func localDoctorEducationToGrpcObject(doctorEducation:DoctorEducationInfo) -> Nambadoctor_V1_DoctorsEducationInfo {
        
        let docEducation = Nambadoctor_V1_DoctorsEducationInfo.with {
            $0.collegeName = doctorEducation.collegeName
            $0.course = doctorEducation.course
            $0.yearPassed = doctorEducation.yearPassed
        }
        
        return docEducation
    }
    
    func localDocEducationListToGrpcList(educationList:[DoctorEducationInfo]) -> [Nambadoctor_V1_DoctorsEducationInfo] {
        
        var educationInfo = [Nambadoctor_V1_DoctorsEducationInfo]()
        
        for education in educationList {
            educationInfo.append(localDoctorEducationToGrpcObject(doctorEducation: education))
        }
        
        return educationInfo
        
    }
    
    func grpcDocEducationListToLocalList(educationList:[Nambadoctor_V1_DoctorsEducationInfo]) -> [DoctorEducationInfo] {
        
        var educationInfo = [DoctorEducationInfo]()
        
        for education in educationList {
            educationInfo.append(grpcToLocalDoctorEducationObject(doctorEducation: education))
        }
        
        return educationInfo
        
    }
}
