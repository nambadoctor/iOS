//
//  CustomerFileInfoMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerFileInfoMapper {
    static func grpcFileInfoToLocal (fileInfo:Nd_V1_CustomerFileInfoMessage) -> CustomerFileInfo {
        return CustomerFileInfo(FileName: fileInfo.fileName.toString,
                                       FileType: fileInfo.fileType.toString,
                                       MediaImage: fileInfo.mediaImage.toString
        )
    }
    
    static func localFileInfoToGrpc (fileInfo:CustomerFileInfo) -> Nd_V1_CustomerFileInfoMessage {
        return Nd_V1_CustomerFileInfoMessage.with {
            $0.fileName = fileInfo.FileName.toProto
            $0.fileType = fileInfo.FileType.toProto
            $0.mediaImage = fileInfo.MediaImage.toProtoBytes
        }
    }
}
