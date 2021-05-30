//
//  SpecialtyCategoryMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/28/21.
//

import Foundation

class SpecialtyCategoryMapper {
    func GrpcToLocalCategory (category:Nd_V1_CategoryMessage) -> SpecialtyCategory {
        return SpecialtyCategory(SpecialityId: category.id.toString,
                                 SpecialityName: category.specialityName.toString,
                                 SpecialityThumbnail: category.specialityThumbnail.toString)
    }
    
    func GrpcToLocalCategory (categories:[Nd_V1_CategoryMessage]) -> [SpecialtyCategory] {
        var localCategoriesList:[SpecialtyCategory] = [SpecialtyCategory]()
        
        for category in categories {
            localCategoriesList.append(GrpcToLocalCategory(category: category))
        }
        
        return localCategoriesList
    }
}
