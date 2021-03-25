//
//  GrpcHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/03/21.
//

import Foundation
import SwiftProtobuf
import SwiftUI

class GrpcHelpers {
    static func convertByteStreamToImage(byteStream:Google_Protobuf_BytesValue) -> UIImage {
        print(byteStream.data.base64EncodedString())
        return Helpers.convertB64ToUIImage(b64Data: byteStream.data.base64EncodedString())!
    }
}
