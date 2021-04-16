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

    var width:CGFloat = 55
    var height:CGFloat = 55
    var textSize:CGFloat = 27

    var body: some View {
        Text(self.word[0])
            .font(.system(size: textSize))
            .foregroundColor(.white)
            .frame(width: width, height: height)
            .background(Circle().fill(color))
    }
}
