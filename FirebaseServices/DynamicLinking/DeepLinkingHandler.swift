//
//  DeepLinkingHandler.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/26/21.
//

import Foundation
import FirebaseDynamicLinks

var docIdFromLink:String = ""

class DeepLinkingHandler {
    func openedWithLink(url:String){
        let docId:String = url.deletingPrefix("https://nambadoctor.com?docId=")
        docIdFromLink = docId
        CustomerMyDoctorsLocalList().addDoctorId(id: docId)
        if UserTypeHelper.checkIfCustomer(userType: UserTypeHelper.getUserType()) {
            CustomerDefaultModifiers.takeToBookDoctor()
        }
    }
    
    func recieveURL (url:URL) {
        _ = DynamicLinks.dynamicLinks().handleUniversalLink(url) { (dynamiclink, error) in
            self.openedWithLink(url: dynamiclink?.url?.absoluteString ?? "")
        }
    }
}
