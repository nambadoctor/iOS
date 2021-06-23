//
//  CustomerRatingView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/6/21.
//

import Foundation
import SwiftUI

struct CustomerRatingViewModifier: ViewModifier {
    @ObservedObject var ratingVM:CustomerRatingViewModel
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $ratingVM.presentRatingSheet) {
                CustomerRatingView(customerRatingVM: self.ratingVM)
                    .onDisappear() {
                        if ratingVM.showSkippedAlert {
                            GlobalPopupHelpers().ThankYouAlert()
                        } else if ratingVM.showSuccessAlert {
                            CustomerAlertHelpers().thanksForFeedback()
                        }
                    }
            }
    }
}

struct CustomerRatingView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var customerRatingVM:CustomerRatingViewModel
    var max: Int32 = 5
    
    var body: some View {
        VStack (spacing: 20) {
            Text("""
How was your consultation with
\(self.customerRatingVM.appointment.serviceProviderName)
""")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
            
            VStack {
                HStack {
                    ForEach(1..<(max + 1), id: \.self) { index in
                        Image(systemName: self.starType(index: Int(index)))
                            .scaleEffect(1.5)
                            .foregroundColor(Color.orange)
                            .onTapGesture {
                                self.customerRatingVM.rating = index
                                self.customerRatingVM.selectStarsWarning = false
                            }
                    }
                }
                
                if self.customerRatingVM.selectStarsWarning {
                    Text("Please select stars")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.top, 5)
                        .modifier(Shake(animatableData: CGFloat(self.customerRatingVM.invalidAttempts)))
                }
            }
            
            Text("Feel free to let us know your feedback")
                .multilineTextAlignment(.center)
            ExpandingTextEntryView(text: self.$customerRatingVM.review)
                .introspectTextField { textField in
                    textField.becomeFirstResponder()
                }
            
            LargeButton(title: "Submit") {
                self.customerRatingVM.setRating()
            }
            
            HStack {
                Spacer()
                Button(action: {
                    self.customerRatingVM.skipRating()
                }, label: {
                    Text("CLICK HERE TO SKIP")
                        .font(.footnote)
                        .foregroundColor(.gray)
                })
            }
            
            Spacer()
        }.padding()
    }
    
    private func starType(index: Int) -> String {
        return index <= customerRatingVM.rating ? "star.fill" : "star"
    }
}
