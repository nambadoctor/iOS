//
//  CategoryPicker.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/25/21.
//

import SwiftUI

struct CategoryPicker : View {
    @Binding var categoriesList:[String]
    @Binding var selectedCategory:String
    var categoryChanged:()->()
    
    var body: some View {
        HStack {
            ScrollView (.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach (self.categoriesList, id: \.self) {category in
                        Text(category)
                            .padding(10)
                            .foregroundColor(category == self.selectedCategory ? Color.white : Color.black)
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
