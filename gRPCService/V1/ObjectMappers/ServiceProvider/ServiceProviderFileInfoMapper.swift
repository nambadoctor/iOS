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
                                       MediaImage: fileInfo.mediaImage.toString,
                                       FileInfoId: fileInfo.fileInfoID.toString
        )
    }
    
    static func grpcFileInfoToLocal (fileInfos:[Nd_V1_ServiceProviderFileInfoMessage]) -> [ServiceProviderFileInfo] {
        var toReturn = [ServiceProviderFileInfo]()
        
        for file in fileInfos {
            toReturn.append(grpcFileInfoToLocal(fileInfo: file))
        }
        
        return toReturn
    }
    
    static func localFileInfoToGrpc (fileInfo:ServiceProviderFileInfo) -> Nd_V1_ServiceProviderFileInfoMessage {
        return Nd_V1_ServiceProviderFileInfoMessage.with {
            $0.fileName = fileInfo.FileName.toProto
            $0.fileType = fileInfo.FileType.toProto
            $0.mediaImage = fileInfo.MediaImage.toProtoBytes
            $0.fileInfoID = fileInfo.FileInfoId.toProto
        }
    }
    
    static func localFileInfoToGrpc (fileInfos:[ServiceProviderFileInfo]) -> Nd_V1_ServiceProviderFileInfoMessageList {
        var toReturn = [Nd_V1_ServiceProviderFileInfoMessage]()
        
        for file in fileInfos {
            toReturn.append(localFileInfoToGrpc(fileInfo: file))
        }
        
        return Nd_V1_ServiceProviderFileInfoMessageList.with {
            $0.fileInfos = toReturn
        }
    }
}
