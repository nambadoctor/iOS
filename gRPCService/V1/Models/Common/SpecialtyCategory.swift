//
//  SpecialtyCategory.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/28/21.
//

import Foundation

struct SpecialtyCategory {
    var SpecialityId:String
    var SpecialityName:String
    var SpecialityThumbnail:String
}

extension SpecialtyCategory: Equatable {
    static func == (lhs: SpecialtyCategory, rhs: SpecialtyCategory) -> Bool {
        return lhs.SpecialityName == rhs.SpecialityName
    }
}
