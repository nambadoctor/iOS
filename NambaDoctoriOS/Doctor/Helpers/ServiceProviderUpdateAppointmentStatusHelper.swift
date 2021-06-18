//
//  UpdateAppointmentStatus.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class ServiceProviderFirebaseUpdateAppointmentStatus {
    private var appointmentId:String
    private var dbRef:AppointmentStatusDatabaseReference
    private var realtimeDBRef:RealtimeDBListener
    
    init(appointmentId:String) {
        self.appointmentId = appointmentId
        self.dbRef = AppointmentStatusDatabaseReference(appointmentId: appointmentId)
        self.realtimeDBRef = RealtimeDBListener(dbQuery: dbRef.ref)
    }
    
    func startListener () {
        realtimeDBRef.observeForAdded { (datasnapshot) in
            let callState = SnapshotDecoder.decodeSnapshot(modelType: String.self, snapshot: datasnapshot)
        }
    }
    
    func writeStartedCallState () {
        let dbWriter = RealtimeDBWriter(dbRef: dbRef.ref)
        dbWriter.writeString(value: "StartedCall")
    }
    
    func writeEndedCallState () {
        let dbWriter = RealtimeDBWriter(dbRef: dbRef.ref)
        dbWriter.writeString(value: "EndedCall")
    }
}

class ServiceProviderUpdateAppointmentStatusHelper:ServiceProviderUpdateAppointmentStatusProtocol {
    
    let AppointmentServiceCalls:ServiceProviderAppointmentServiceProtocol
    
    init(AppointmentServiceCalls:ServiceProviderAppointmentServiceProtocol = ServiceProviderAppointmentService()) {
        self.AppointmentServiceCalls = AppointmentServiceCalls
    }

    func toCancelled (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {
        appointment.status = "Cancelled"
                
        AppointmentServiceCalls.setAppointment(appointment: appointment) { (updated) in
            if updated {
                CommonDefaultModifiers.hideLoader()
                completion(true)
            } else { }
        }
    }

    func updateToStartedConsultation (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {

        appointment.status = "StartedConsultation"
        appointment.actualAppointmentStartTime = Date().millisecondsSince1970
        
        AppointmentServiceCalls.setAppointment(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }

    func updateToFinished (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {

        appointment.status = "Finished"
        appointment.actualAppointmentStartTime = Date().millisecondsSince1970
        appointment.actualAppointmentEndTime = Date().millisecondsSince1970
        
        AppointmentServiceCalls.setAppointment(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }

    func updateToFinishedAppointment (appointment:inout ServiceProviderAppointment, completion: @escaping (_ success:Bool) -> ()) {

        appointment.status = "FinishedAppointment"

        AppointmentServiceCalls.setAppointment(appointment: appointment) { (updated) in
            if updated { completion(true) } else { }
        }
    }
}
