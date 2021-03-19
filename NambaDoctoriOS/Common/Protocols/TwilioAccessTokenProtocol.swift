//
//  TwilioAccessTokenProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

protocol TwilioAccessTokenProtocol {
    func retrieveToken (appointmentId:String,
                        serviceProviderId:String,
                        completion: @escaping ((_ success:Bool, _ twilioToke:String?)->()))
}
