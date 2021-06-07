//
//  RatingAndReviewService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/6/21.
//

import Foundation

class RatingAndReviewService {
    func setRatingAndReview (rating:RatingAndReview, completion: @escaping (_ success:Bool)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        // Provide the connection to the generated client.
        let ratingClient = Nd_V1_RatingAndReviewWorkerV1Client(channel: channel)
         
        let request = RatingAndReviewMapper.LocalRatingToGrpc(rating: rating)
        
        print("RATING REQUEST: \(request)")
        
        let setRatingsCall = ratingClient.setRating(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try setRatingsCall.response.wait()
                print("SET RATING CALL SUCCESS: \(response)")
            } catch {
                print("SET RATING CALL FAILED: \(error.localizedDescription)")
            }
        }
    }
    
    func getRatingAndReview (appointmentId:String, completion: @escaping (_ rating:RatingAndReview?)->()) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        // Provide the connection to the generated client.
        let ratingClient = Nd_V1_RatingAndReviewWorkerV1Client(channel: channel)
         
        let request = Nd_V1_RatingRequestMessage.with {
            $0.appointmentID = appointmentId.toProto
            $0.reviewerID = UserIdHelper().retrieveUserId().toProto
        }
        
        let setRatingsCall = ratingClient.getRating(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try setRatingsCall.response.wait()
                let rating = RatingAndReviewMapper.GrpcRatingToLocal(ratingMessage: response)
                completion(rating)
                print("GET RATING CALL SUCCESS: \(response)")
            } catch {
                print("GET RATING CALL FAILED: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
