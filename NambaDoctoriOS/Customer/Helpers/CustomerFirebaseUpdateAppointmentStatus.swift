//
//  CustomerFirebaseUpdateAppointmentStatus.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/18/21.
//

import Foundation

enum FirebaseCallState:String {
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
        realtimeDBRef.valueListener { (datasnapshot) in
            let callState = SnapshotDecoder.decodeSnapshot(modelType: String.self, snapshot: datasnapshot)
            
            if callState == FirebaseCallState.StartedCall.rawValue && !cusAutoNav.currentlyInTwilioRoom {
                CustomerNotificationHandlerHelper().callNotif(appointmentId: self.appointmentId, userInfo: self.generateCustomerAPNPayload())
            }
        }
    }

    func generateCustomerAPNPayload () -> [AnyHashable: Any] {
        let jsonObject: [AnyHashable: Any] = [
            "aps": [
                "category" : "",
                "alert" : [
                    "title" : "Doctor Is Calling",
                    "body" : "Please Click Here To Answer",
                    "type" : NotifTypes.CallInRoom.rawValue,
                    "id" : self.appointmentId
                ],
                "sound" : "default"
            ]
        ]
        return jsonObject
    }
    
    func writePatientJoinedState () {
        let dbWriter = RealtimeDBWriter(dbRef: dbRef.ref)
        dbWriter.writeString(value: "PatientJoined")
    }
}
