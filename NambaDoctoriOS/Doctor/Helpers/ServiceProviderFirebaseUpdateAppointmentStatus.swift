//
//  ServiceProviderFirebaseUpdateAppointmentStatus.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/18/21.
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
