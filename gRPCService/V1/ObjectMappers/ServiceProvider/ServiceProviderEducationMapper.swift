//
//  ServiceProviderEducationMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderEducationMapper {
    static func grpcEducationToLocal (education:Nd_V1_ServiceProviderEducation) -> ServiceProviderEducation {
        return ServiceProviderEducation(
            course: education.course.toString,
            year: education.year.toInt32,
            country: education.country.toString,
            college: education.college.toString,
            university: education.university.toString,
            educationID: education.educationID.toString)
    }
    
    static func grpcEducationToLocal (education:[Nd_V1_ServiceProviderEducation]) -> [ServiceProviderEducation] {
        var educationList:[ServiceProviderEducation] = [ServiceProviderEducation]()
        
        for edu in education {
            educationList.append(grpcEducationToLocal(education: edu))
        }
        
        return educationList
    }
    
    static func localEducationToGrpc (education:ServiceProviderEducation) -> Nd_V1_ServiceProviderEducation {
        return Nd_V1_ServiceProviderEducation.with {
            $0.course = education.course.toProto
            $0.year = education.year.toProto
            $0.country = education.country.toProto
            $0.college = education.college.toProto
            $0.university = education.university.toProto
            $0.educationID = education.educationID.toProto
        }
    }
    
    static func localEducationToGrpc (education:[ServiceProviderEducation]) -> [Nd_V1_ServiceProviderEducation] {
        var educationList:[Nd_V1_ServiceProviderEducation] = [Nd_V1_ServiceProviderEducation]()
        
        for edu in education {
            educationList.append(localEducationToGrpc(education: edu))
        }
        
        return educationList
    }
}
