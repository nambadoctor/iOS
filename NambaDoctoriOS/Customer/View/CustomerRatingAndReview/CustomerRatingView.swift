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
            }
    }
}


struct CustomerRatingView: View {
    @ObservedObject var customerRatingVM:CustomerRatingViewModel
    var max: Int32 = 5
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1..<(max + 1), id: \.self) { index in
                    Image(systemName: self.starType(index: Int(index)))
                        .foregroundColor(Color.orange)
                        .onTapGesture {
                            self.customerRatingVM.rating = index
                        }
                }
            }
            
            Text("Please let us know your thoughts about the consultation and \(customerRatingVM.appointment.serviceProviderName)")
            ExpandingTextView(text: self.$customerRatingVM.review)
            
            LargeButton(title: "Submit") {
                self.customerRatingVM.setRating()
            }
        }.padding()
    }
    
    private func starType(index: Int) -> String {
        return index <= customerRatingVM.rating ? "star.fill" : "star"
    }
}

class CustomerRatingViewModel: ObservableObject {
    @Published var review:String = ""
    @Published var rating:Int32 = 0
    @Published var skipReview:Bool = false
    @Published var presentRatingSheet = false
    var appointment:CustomerAppointment
    
    init(appointment:CustomerAppointment) {
        self.appointment = appointment
    }
    
    func makeRatingObj () -> RatingAndReview{
        return RatingAndReview(RatingAndReviewId: "",
                               Stars: rating,
                               Comment: review,
                               ServiceProviderId: appointment.serviceProviderID,
                               CustomerId: appointment.customerID,
                               AppointmentId: appointment.appointmentID,
                               UserType: UserTypeHelper.getUserType(),
                               ReviewerId: UserIdHelper().retrieveUserId(),
                               SkippedReview: skipReview,
                               IsDeleted: false)
    }
    
    func setRating () {
        RatingAndReviewService().setRatingAndReview(rating: makeRatingObj()) { success in
            self.presentRatingSheet = false
        }
    }
}
