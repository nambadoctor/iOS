//
//  ServiceProviderWorkExperienceMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderWorkExperienceMapper {
    static func grpcWorkToLocal(work:Nd_V1_ServiceProviderWorkExperience) -> ServiceProviderWorkExperience {
        return ServiceProviderWorkExperience(
            organisation: work.organization.toString,
            startDate: work.startDate.toInt64,
            endDate: work.endDate.toInt64,
            workExperienceID: work.workExperienceID.toString)
    }
    
    static func grpcWorkToLocal(work:[Nd_V1_ServiceProviderWorkExperience]) -> [ServiceProviderWorkExperience] {
        
        var workList:[ServiceProviderWorkExperience] = [ServiceProviderWorkExperience]()
        
        for w in work {
            workList.append(grpcWorkToLocal(work: w))
        }
        
        return workList
        
    }
    
    static func localWorkToGrpc(work:ServiceProviderWorkExperience) -> Nd_V1_ServiceProviderWorkExperience{
        return Nd_V1_ServiceProviderWorkExperience.with {
            $0.organization = work.organisation.toProto
            $0.startDate = work.startDate.toProto
            $0.endDate = work.endDate.toProto
            $0.workExperienceID = work.workExperienceID.toProto
        }
    }
    
    static func localWorkToGrpc(work:[ServiceProviderWorkExperience]) -> [Nd_V1_ServiceProviderWorkExperience] {

        var workList:[Nd_V1_ServiceProviderWorkExperience] = [Nd_V1_ServiceProviderWorkExperience]()

        for w in work {
            workList.append(localWorkToGrpc(work: w))
        }

        return workList
        
    }
}
