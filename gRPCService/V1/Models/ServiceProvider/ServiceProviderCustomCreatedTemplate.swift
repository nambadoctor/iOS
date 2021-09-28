//
//  ServiceProviderCustomCreatedTemplate.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 9/21/21.
//

import Foundation

struct ServiceProviderCustomCreatedTemplate {
    var templateId:String
    var templateName:String
    var serviceProviderID:String
    var diagnosis:ServiceProviderDiagnosis
    var investigations:[String]
    var advice:String
    var createdDateTime:Int64
    var lastModifiedDate:Int64
    var medicines:[ServiceProviderMedicine]
}
