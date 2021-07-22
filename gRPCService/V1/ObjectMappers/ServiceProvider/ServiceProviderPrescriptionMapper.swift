//
//  ServiceProviderPrescriptionMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderPrescriptionMapper {
    func grpcPrescriptionToLocal (prescription:Nd_V1_ServiceProviderPrescriptionMessage) -> ServiceProviderPrescription {
        return ServiceProviderPrescription(
            prescriptionID: prescription.prescriptionID.toString,
            serviceRequestID: prescription.serviceRequestID.toString,
            customerID: prescription.customerID.toString,
            createdDateTime: prescription.createdDateTime.toInt64,
            medicineList: ServiceProviderMedicineMapper.grpcMedicineToLocal(medicines: prescription.medicineList),
            fileInfo: ServiceProviderFileInfoMapper.grpcFileInfoToLocal(fileInfo: prescription.fileInfo),
            uploadedPrescriptionDocuments: ServiceProviderFileInfoMapper.grpcFileInfoToLocal(fileInfos: prescription.uploadedPrescriptionDocuments.fileInfos))
    }

    func localPrescriptionToGrpc (prescription: ServiceProviderPrescription) -> Nd_V1_ServiceProviderPrescriptionMessage {
        return Nd_V1_ServiceProviderPrescriptionMessage.with {
            $0.prescriptionID = prescription.prescriptionID.toProto
            $0.serviceRequestID = prescription.serviceRequestID.toProto
            $0.customerID = prescription.customerID.toProto
            $0.createdDateTime = prescription.createdDateTime.toProto
            $0.medicineList = ServiceProviderMedicineMapper.localMedicineToGrpc(medicines: prescription.medicineList)
            $0.fileInfo = ServiceProviderFileInfoMapper.localFileInfoToGrpc(fileInfo: prescription.fileInfo)
            $0.uploadedPrescriptionDocuments = ServiceProviderFileInfoMapper.localFileInfoToGrpc(fileInfos: prescription.uploadedPrescriptionDocuments)
        }
    }
}
