//
//  CustomerRatingViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/7/21.
//

import Foundation
import SwiftUI

class CustomerRatingViewModel: ObservableObject {
    @Published var review:String = ""
    @Published var rating:Int32 = 0
    @Published var skipReview:Bool = false
    @Published var presentRatingSheet = false
    @Published var selectStarsWarning = false
    @Published var invalidAttempts: Int = 0
    var appointment:CustomerAppointment
    
    var showSuccessAlert:Bool = false
    var showSkippedAlert:Bool = false
    
    init(appointment:CustomerAppointment) {
        self.appointment = appointment
    }
    
    func makeRatingObj () -> RatingAndReview {
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
        
        guard self.rating != 0 else {
            withAnimation(.default) {
                self.invalidAttempts += 1
            }
            self.selectStarsWarning = true
            return
        }
        DispatchQueue.main.async {
            self.showSuccessAlert = true
            self.presentRatingSheet = false
        }
        //RatingAndReviewService().setRatingAndReview(rating: makeRatingObj()) { success in }
    }

    func skipRating () {
        self.showSkippedAlert = true
        self.skipReview = true
        self.setRating()
    }
}
