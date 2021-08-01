//
//  CategoryPicker.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/25/21.
//

import SwiftUI

struct CategoryPicker : View {
    @Binding var categoriesList:[Category]
    @Binding var selectedCategory:Category
    var categoryChanged:()->()
    
    var body: some View {
        HStack {
            ScrollView (.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach (self.categoriesList, id: \.CategoryName) {category in
                        HStack {
                            ImageViewWithNoSheet(url: category.CategoryThumbnail, height: 30, width: 30)
                            
                            Text(category.CategoryName)
                                .foregroundColor(category == self.selectedCategory ? Color.white : .black)

                        }
                        .padding(10)
                        .background(category == self.selectedCategory ? Color.blue : Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .onTapGesture {
                            self.selectedCategory = category
                            self.categoryChanged()
                        }
                    }
                }
            }
        }
        .padding(.leading)
    }
}
