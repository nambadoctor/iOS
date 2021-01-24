//
//  UploadedDocument.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

class UploadedDocument: Identifiable, Codable {
    internal init(createdDateTime: String? = nil, docType: String? = nil, documentName: String? = nil, documnetId: String? = nil) {
        self.createdDateTime = createdDateTime
        self.docType = docType
        self.documentName = documentName
        self.documnetId = documnetId
    }
    
    var createdDateTime:String!
    var docType:String!
    var documentName:String!
    var documnetId:String!
}
