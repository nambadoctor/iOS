//
//  ServiceProviderFileInfo.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/03/21.
//

import Foundation
import SwiftUI

struct ServiceProviderFileInfo : Codable {
    var FileName:String
    var FileType:String
    var MediaImage:String //base encoded 64 string...
}
