//
//  SpecialtyCategoryMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/28/21.
//

import Foundation

class SpecialtyCategoryMapper {
    func GrpcToLocalCategory (category:Nd_V1_CategoryMessage) -> Category {
        return Category(CategoryId: category.id.toString,
                                 CategoryName: category.specialityName.toString,
                                 CategoryThumbnail: category.specialityThumbnail.toString)
    }
    
    func GrpcToLocalCategory (categories:[Nd_V1_CategoryMessage]) -> [Category] {
        var localCategoriesList:[Category] = [Category]()
        
        for category in categories {
            localCategoriesList.append(GrpcToLocalCategory(category: category))
        }
        
        return localCategoriesList
    }
}
