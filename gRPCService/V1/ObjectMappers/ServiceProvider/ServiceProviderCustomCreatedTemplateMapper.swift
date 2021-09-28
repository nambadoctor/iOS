//
//  ServiceProviderCustomCreatedTemplateMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 9/21/21.
//

import Foundation

class ServiceProviderCustomCreatedTemplateMapper {
    static func grpcToLocal (grpcTemplate:Nd_V1_ServiceProviderCustomCreatedTemplateMessage) -> ServiceProviderCustomCreatedTemplate {
        return ServiceProviderCustomCreatedTemplate(templateId: grpcTemplate.templateID.toString,
                                                    templateName: grpcTemplate.templateName.toString,
                                                    serviceProviderID: grpcTemplate.serviceProviderID.toString,
                                                    diagnosis: ServiceProviderDiagnosisObjectMapper.grpcDiagnosisToLocal(diagnosis: grpcTemplate.diagnosis),
                                                    investigations: grpcTemplate.investigations.convert(),
                                                    advice: grpcTemplate.advice.toString,
                                                    createdDateTime: grpcTemplate.createdDateTime.toInt64,
                                                    lastModifiedDate: grpcTemplate.lastModifedDate.toInt64,
                                                    medicines: ServiceProviderMedicineMapper.grpcMedicineToLocal(medicines: grpcTemplate.medicines))
    }
    
    static func localToGrpc (localTemplate:ServiceProviderCustomCreatedTemplate) -> Nd_V1_ServiceProviderCustomCreatedTemplateMessage {
        return Nd_V1_ServiceProviderCustomCreatedTemplateMessage.with {
            $0.templateID = localTemplate.templateId.toProto
            $0.templateName = localTemplate.templateName.toProto
            $0.serviceProviderID = localTemplate.serviceProviderID.toProto
            $0.diagnosis = ServiceProviderDiagnosisObjectMapper.localDiagnosisToGrpc(diagnosis: localTemplate.diagnosis)
            $0.investigations = localTemplate.investigations.convert()
            $0.advice = localTemplate.advice.toProto
            $0.createdDateTime = localTemplate.createdDateTime.toProto
            $0.lastModifedDate = localTemplate.lastModifiedDate.toProto
            $0.medicines = ServiceProviderMedicineMapper.localMedicineToGrpc(medicines: localTemplate.medicines)
        }
    }
    
    static func grpcToLocal (grpcTemplates:Nd_V1_ServiceProviderCustomCreatedTemplateListMessage) -> [ServiceProviderCustomCreatedTemplate]  {
        var templateList = [ServiceProviderCustomCreatedTemplate] ();
        
        for template in grpcTemplates.templateList {
            templateList.append(grpcToLocal(grpcTemplate: template))
        }
        
        return templateList
    }
}
