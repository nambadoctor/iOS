//
//  LetterOnColoredCircle.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/9/21.
//

import SwiftUI

struct LetterOnColoredCircle: View {
    
    var word:String
    var color:Color
    
    var body: some View {
        Text(self.word[0])
            .font(.system(size: 27))
            .foregroundColor(.white)
            .frame(width: 55, height: 55)
            .background(Circle().fill(color))
    }
}
