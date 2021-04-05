//
//  ServiceProviderFileInfoMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/03/21.
//

import Foundation

class ServiceProviderFileInfoMapper {
    static func grpcFileInfoToLocal (fileInfo:Nd_V1_ServiceProviderFileInfoMessage) -> ServiceProviderFileInfo {
        return ServiceProviderFileInfo(FileName: fileInfo.fileName.toString,
                                       FileType: fileInfo.fileType.toString,
                                       MediaImage: fileInfo.mediaImage.toString
        )
    }
    
    static func localFileInfoToGrpc (fileInfo:ServiceProviderFileInfo) -> Nd_V1_ServiceProviderFileInfoMessage {
        return Nd_V1_ServiceProviderFileInfoMessage.with {
            $0.fileName = fileInfo.FileName.toProto
            $0.fileType = fileInfo.FileType.toProto
            $0.mediaImage = fileInfo.MediaImage.toProtoBytes 
        }
    }
}
