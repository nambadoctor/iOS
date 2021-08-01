//
//  SpecialtyCategory.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/28/21.
//

import Foundation

struct Category {
    var CategoryId:String
    var CategoryName:String
    var CategoryThumbnail:String
}

extension Category: Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.CategoryName == rhs.CategoryName
    }
}
