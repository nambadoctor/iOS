//
//  CustomerFirebaseUpdateAppointmentStatus.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/18/21.
//

import Foundation

enum FirebaseCallState {
    case PatientJoined
    case EndedCall
    case StartedCall
}

class CustomerFirebaseUpdateAppointmentStatus {
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

    func writePatientJoinedState () {
        let dbWriter = RealtimeDBWriter(dbRef: dbRef.ref)
        dbWriter.writeString(value: "PatientJoined")
    }
}
