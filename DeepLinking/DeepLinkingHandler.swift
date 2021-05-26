//
//  DeepLinkingHandler.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/26/21.
//

import Foundation

var docIdFromLink:String = ""

class DeepLinkingHandler {
    func openedWithLink(url:String){
        let docId:String = url.deletingPrefix("https://nambadoctor.page.link/")
        docIdFromLink = docId
        if UserTypeHelper.checkIfCustomer(userType: UserTypeHelper.getUserType()) {
            print("STARTING TO HANDLE LINK!")
            CustomerDefaultModifiers.takeToBookDoctor()
        }
    }
}
