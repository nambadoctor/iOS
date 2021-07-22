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
                                       MediaImage: fileInfo.mediaImage.toString,
                                       FileInfoId: fileInfo.fileInfoID.toString
        )
    }
    
    
    static func grpcFileInfoToLocal (fileInfos:[Nd_V1_CustomerFileInfoMessage]) -> [CustomerFileInfo] {
        var toReturn = [CustomerFileInfo]()
        
        for file in fileInfos {
            toReturn.append(grpcFileInfoToLocal(fileInfo: file))
        }
        
        return toReturn
    }
    
    static func localFileInfoToGrpc (fileInfo:CustomerFileInfo) -> Nd_V1_CustomerFileInfoMessage {
        return Nd_V1_CustomerFileInfoMessage.with {
            $0.fileName = fileInfo.FileName.toProto
            $0.fileType = fileInfo.FileType.toProto
            $0.mediaImage = fileInfo.MediaImage.toProtoBytes
            $0.fileInfoID = fileInfo.FileInfoId.toProto
        }
    }
    
    static func localFileInfoToGrpc (fileInfos:[CustomerFileInfo]) -> Nd_V1_CustomerFileInfoMessageList {
        var toReturn = [Nd_V1_CustomerFileInfoMessage]()
        
        for file in fileInfos {
            toReturn.append(localFileInfoToGrpc(fileInfo: file))
        }
        
        return Nd_V1_CustomerFileInfoMessageList.with {
            $0.fileInfos = toReturn
        }
    }
}
