//
//  RatingAndReviewMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/6/21.
//

import Foundation

class RatingAndReviewMapper {
    static func GrpcRatingToLocal (ratingMessage:Nd_V1_RatingAndReviewMessage) -> RatingAndReview {
        return RatingAndReview(RatingAndReviewId: ratingMessage.ratingAndReviewID.toString,
                               Stars: ratingMessage.stars.toInt32,
                               Comment: ratingMessage.comment.toString,
                               ServiceProviderId: ratingMessage.serviceProviderID.toString,
                               CustomerId: ratingMessage.customerID.toString,
                               AppointmentId: ratingMessage.appointmentID.toString,
                               UserType: ratingMessage.userType.toString,
                               ReviewerId: ratingMessage.reviewerID.toString,
                               SkippedReview: ratingMessage.skippedReview.toBool,
                               IsDeleted: ratingMessage.isDeleted.toBool)
    }
    
    static func LocalRatingToGrpc (rating:RatingAndReview) -> Nd_V1_RatingAndReviewMessage {
        return Nd_V1_RatingAndReviewMessage.with {
            $0.ratingAndReviewID = rating.RatingAndReviewId.toProto
            $0.stars = rating.Stars.toProto
            $0.comment = rating.Comment.toProto
            $0.serviceProviderID = rating.ServiceProviderId.toProto
            $0.customerID = rating.CustomerId.toProto
            $0.appointmentID = rating.AppointmentId.toProto
            $0.userType = rating.UserType.toProto
            $0.reviewerID = rating.ReviewerId.toProto
            $0.skippedReview = rating.SkippedReview.toProto
            $0.isDeleted = rating.IsDeleted.toProto
        }
    }
}
