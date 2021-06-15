//
//  SnackbarView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/15/21.
//

import SwiftUI

var snackBarValues = SnackBarDisplayValues()

class SnackBarDisplayValues {
    var imageName:String = ""
    var title:String = ""
    var message:String = ""
    var backgroundColor:Color = .gray
    var foregroundColor:Color = .black
}

struct Snackbar: View {
    
    @State private var imageName:String = ""
    @State private var title:String = ""
    @State private var message:String = ""
    @State private var backgroundColor:Color = .gray
    @State private var foregroundColor:Color = .black

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: self.imageName)
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                .frame(width: 40, height: 40)
                .foregroundColor(self.foregroundColor)

            VStack(alignment: .leading, spacing: 4) {
                Text(self.title)
                    .foregroundColor(self.foregroundColor)
                    .font(.headline)

                Text(self.message)
                    .font(.body)
                    .foregroundColor(self.foregroundColor)
            }
        }
        .padding(15)
        .frame(maxWidth: .infinity, idealHeight: 100)
        .background(self.backgroundColor)
        .onAppear() {updateValues()}
    }
    
    func updateValues () {
        self.imageName = snackBarValues.imageName
        self.title = snackBarValues.title
        self.message = snackBarValues.message
        self.backgroundColor = snackBarValues.backgroundColor
        self.foregroundColor = snackBarValues.foregroundColor
        
        print("VALUEAKKAJENFW \(self.imageName) \(self.title) \(self.message)")
    }
}
