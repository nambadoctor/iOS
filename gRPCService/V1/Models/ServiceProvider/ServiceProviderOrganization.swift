//
//  ServiceProviderOrganization.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/20/21.
//

import Foundation

struct ServiceProviderOrganisation {
    var organisationId:String
    var phoneNumbers:[PhoneNumber]
    var addresses:[ServiceProviderAddress]
    var organisationTimings:[ServiceProviderOrganisationTiming]
    var emailAddresses:[String]
    var adImages:[String]
    var specialities:[String]
    var links:[String]
    var doctorIds:[String]
    var secretaryIds:[String]
    var name:String
    var description:String
    var type:String
    var createdDate:Int64
    var lastModifedDate:Int64
    var logo:String
}
