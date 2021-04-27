//
//  CustomerEducationMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerEducationMapper {
    static func grpcEducationToLocal (education:Nd_V1_CustomerEducation) -> CustomerEducation {
        return CustomerEducation(
            course: education.course.toString,
            year: education.year.toInt32,
            country: education.country.toString,
            college: education.college.toString,
            university: education.university.toString,
            educationID: education.educationID.toString)
    }
    
    static func grpcEducationToLocal (education:[Nd_V1_CustomerEducation]) -> [CustomerEducation] {
        var educationList:[CustomerEducation] = [CustomerEducation]()
        
        for edu in education {
            educationList.append(grpcEducationToLocal(education: edu))
        }
        
        return educationList
    }
    
    static func localEducationToGrpc (education:CustomerEducation) -> Nd_V1_CustomerEducation {
        return Nd_V1_CustomerEducation.with {
            $0.course = education.course.toProto
            $0.year = education.year.toProto
            $0.country = education.country.toProto
            $0.college = education.college.toProto
            $0.university = education.university.toProto
            $0.educationID = education.educationID.toProto
        }
    }
    
    static func localEducationToGrpc (education:[CustomerEducation]) -> [Nd_V1_CustomerEducation] {
        var educationList:[Nd_V1_CustomerEducation] = [Nd_V1_CustomerEducation]()
        
        for edu in education {
            educationList.append(localEducationToGrpc(education: edu))
        }
        
        return educationList
    }

}
