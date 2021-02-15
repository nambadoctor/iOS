//
//  AppointmentObjMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

class AppointmentObjMapper {
    func grpcToLocalAppointmentObject(appointment:Nambadoctor_V1_AppointmentObject) -> Appointment {
        let appointment = Appointment(appointmentID: appointment.appointmentID,
                                      preferredLanguage: appointment.preferredLanguage,
                                      status: appointment.status,
                                      doctorID: appointment.doctorID,
                                      doctorName: appointment.doctorName,
                                      requestedBy: appointment.requestedBy,
                                      patientName: appointment.patientName,
                                      consultationFee: appointment.consultationFee,
                                      paymentStatus: appointment.paymentStatus,
                                      problemDetails: appointment.problemDetails,
                                      createdDateTime: appointment.createdDateTime,
                                      slotID: appointment.slotID,
                                      discountedConsultationFee: appointment.discountedConsultationFee,
                                      requestedTime: appointment.requestedTime,
                                      noOfReports: appointment.noOfReports)
        
        return appointment
    }
    
    func localAppointmentToGrpcObject(appointment:Appointment) -> Nambadoctor_V1_AppointmentObject {
        let appointment = Nambadoctor_V1_AppointmentObject.with {
            $0.preferredLanguage = appointment.preferredLanguage
            $0.status = appointment.status
            $0.doctorID = appointment.doctorID
            $0.doctorName = appointment.doctorName
            $0.requestedBy = appointment.requestedBy
            $0.patientName = appointment.patientName
            $0.consultationFee = appointment.consultationFee
            $0.paymentStatus = appointment.paymentStatus
            $0.problemDetails = appointment.problemDetails
            $0.createdDateTime = appointment.createdDateTime
            $0.slotID = appointment.slotID
            $0.discountedConsultationFee = appointment.discountedConsultationFee
            $0.requestedTime = appointment.requestedTime
            $0.noOfReports = appointment.noOfReports
        }
        
        return appointment
    }
    
    func grpcAppointmentListToLocalAppointmentList(appointmentList:[Nambadoctor_V1_AppointmentObject]) -> [Appointment] {
        
        var localAppointmentList = [Appointment]()
        
        for appointment in appointmentList {
            localAppointmentList.append(grpcToLocalAppointmentObject(appointment: appointment))
        }
        
        return localAppointmentList
    }

}
