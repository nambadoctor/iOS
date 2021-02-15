//
//  DoctorExperienceMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

class DoctorExperienceMapper {
    func grpcToLocalDoctorExperienceObject(doctorExperience:Nambadoctor_V1_DoctorsExperience) -> DoctorExperience {
        
        let docExperience = DoctorExperience(currentlyWorking: doctorExperience.currentlyWorking,
                                             startDateTime: doctorExperience.startDateTime,
                                             endDateTime: doctorExperience.endDateTime,
                                             company: doctorExperience.company)
        
        return docExperience
        
    }
    
    func localDoctorExperienceToGrpcObject(doctorExperience:DoctorExperience) -> Nambadoctor_V1_DoctorsExperience {
        
        let docExperience = Nambadoctor_V1_DoctorsExperience.with {
            $0.currentlyWorking = doctorExperience.currentlyWorking
            $0.startDateTime = doctorExperience.startDateTime
            $0.endDateTime = doctorExperience.endDateTime
            $0.company = doctorExperience.company
        }
        
        return docExperience
    }
    
    func localDocExperienceListToGrpcList(experienceList:[DoctorExperience]) -> [Nambadoctor_V1_DoctorsExperience] {
        
        var experienceInfo = [Nambadoctor_V1_DoctorsExperience]()
        
        for experience in experienceList {
            experienceInfo.append(localDoctorExperienceToGrpcObject(doctorExperience: experience))
        }
        
        return experienceInfo
        
    }
    
    func grpcDocExperienceListToLocalList(experienceList:[Nambadoctor_V1_DoctorsExperience]) -> [DoctorExperience] {
        
        var experienceInfo = [DoctorExperience]()
        
        for experience in experienceList {
            experienceInfo.append(grpcToLocalDoctorExperienceObject(doctorExperience: experience))
        }
        
        return experienceInfo
        
    }
}
