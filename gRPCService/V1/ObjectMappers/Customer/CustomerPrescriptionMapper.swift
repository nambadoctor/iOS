//
//  CustomerPrescriptionMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerPrescriptionMapper {
    func grpcPrescriptionToLocal (prescription:Nd_V1_CustomerPrescriptionMessage) -> CustomerPrescription {
        return CustomerPrescription(
            prescriptionID: prescription.prescriptionID.toString,
            serviceRequestID: prescription.serviceRequestID.toString,
            customerID: prescription.customerID.toString,
            createdDateTime: prescription.createdDateTime.toInt64,
            medicineList: CustomerMedicineMapper.grpcMedicineToLocal(medicines: prescription.medicineList),
            fileInfo: CustomerFileInfoMapper.grpcFileInfoToLocal(fileInfo: prescription.fileInfo))
    }
    
    func localPrescriptionToGrpc (prescription: CustomerPrescription) -> Nd_V1_CustomerPrescriptionMessage {
        return Nd_V1_CustomerPrescriptionMessage.with {
            $0.prescriptionID = ""//prescription.prescriptionID.toProto
            $0.serviceRequestID = prescription.serviceRequestID.toProto
            $0.customerID = prescription.customerID.toProto
            $0.createdDateTime = prescription.createdDateTime.toProto
            $0.medicineList = CustomerMedicineMapper.localMedicineToGrpc(medicines: prescription.medicineList)
            $0.fileInfo = CustomerFileInfoMapper.localFileInfoToGrpc(fileInfo: prescription.fileInfo)
        }
    }
}
