//
//  ContentView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var loginStatus:UserLoginStatus = UserLoginStatus.NotSignedIn
    
    
    var body: some View {
        VStack {
            switch loginStatus {
            case .Doctor:
                DoctorHome(doctorViewModel: .init())
            case .Patient:
                Text("PATIENT HOME")
            case .NotSignedIn:
                PhoneVerificationview(preRegUser: .init())
            }
        }.onAppear() {
            loginStateListener()
        }
    }
}

//MARK: STATE CHANGE OBSERVERS
extension ContentView {
    func loginStateListener () {
        //Opening value check
        let status = UserDefaults.standard.value(forKey: "\(SimpleStateK.loginStatus)") ?? ""
        loginStatus = CheckLoginStatus.checkStatus(loggedInStatus: status as! String)
        
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("\(SimpleStateK.loginStatusChange)"),
                         object: nil,
                         queue: .main) { (_) in
                let status = UserDefaults.standard.value(forKey: "\(SimpleStateK.loginStatus)")
                loginStatus = CheckLoginStatus.checkStatus(loggedInStatus: status as! String)
        }
    }
}
