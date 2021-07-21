//
//  CustomerWorkExperienceMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerWorkExperienceMapper {
    static func grpcWorkToLocal(work:Nd_V1_CustomerWorkExperience) -> CustomerWorkExperience {
        return CustomerWorkExperience(
            organisation: work.organization.toString,
            startDate: work.startDate.toInt64,
            endDate: work.endDate.toInt64,
            workExperienceID: work.workExperienceID.toString)
    }

    static func grpcWorkToLocal(work:[Nd_V1_CustomerWorkExperience]) -> [CustomerWorkExperience] {
        
        var workList:[CustomerWorkExperience] = [CustomerWorkExperience]()
        
        for w in work {
            workList.append(grpcWorkToLocal(work: w))
        }

        return workList
    }

    static func localWorkToGrpc(work:CustomerWorkExperience) -> Nd_V1_CustomerWorkExperience{
        return Nd_V1_CustomerWorkExperience.with {
            $0.organization = work.organisation.toProto
            $0.startDate = work.startDate.toProto
            $0.endDate = work.endDate.toProto
            $0.workExperienceID = work.workExperienceID.toProto
        }
    }
    
    static func localWorkToGrpc(work:[CustomerWorkExperience]) -> [Nd_V1_CustomerWorkExperience] {

        var workList:[Nd_V1_CustomerWorkExperience] = [Nd_V1_CustomerWorkExperience]()

        for w in work {
            workList.append(localWorkToGrpc(work: w))
        }

        return workList
        
    }

}
