//
//  CreateDynamicLink.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/28/21.
//

import Foundation
import FirebaseDynamicLinks

class CreateDynamicLink {
    func makeLink (doctorId:String, doctorName:String, profilePicURL:String, completion: @escaping (_ url:String)->()) {
        guard let link = URL(string: "https://nambadoctor.com?docId=\(doctorId)") else { return }
        let dynamicLinksDomainURIPrefix = "https://nambadoctor.page.link"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        linkBuilder!.iOSParameters = DynamicLinkIOSParameters(bundleID: "nambadoctor.iOS.NambaDoctor")
        linkBuilder!.androidParameters = DynamicLinkAndroidParameters(packageName: "com.nambadoctor")
        
        linkBuilder!.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder!.socialMetaTagParameters!.title = doctorName
        linkBuilder!.socialMetaTagParameters!.descriptionText = "Click the link to consult with \(doctorName)!"
        linkBuilder!.socialMetaTagParameters!.imageURL = URL(string: profilePicURL)
        
        linkBuilder!.options = DynamicLinkComponentsOptions()
        linkBuilder!.options!.pathLength = .short
        
        linkBuilder!.shorten() { url, warnings, error in
            completion(url!.absoluteString)
        }
    }
}
