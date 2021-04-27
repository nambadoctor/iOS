//
//  ContentView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import SwiftUI

struct ContentView: View {
    @State private var loginStatus:UserLoginStatus = UserLoginStatus.NotSignedIn
    @State private var showLoader:Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                switch loginStatus {
                case .ServiceProvider:
                    DoctorHome(doctorViewModel: .init())
                case .Customer:
                    CustomerHome(customerVM: .init())
                case .NotSignedIn:
                    PhoneVerificationview(preRegUser: .init())
                }
            }
        }
        .overlay(LoadingScreen(showLoader: self.$showLoader))
        .onAppear() {
            loginStateListener()
            showLoaderListener()
        }
    }
}

//MARK: STATE CHANGE OBSERVERS
extension ContentView {
    func loginStateListener () {
        //Opening value check
        let status = GetUserTypeHelper.getUserType()
        loginStatus = CheckLoginStatus.checkStatus(loggedInStatus: status)
        print("LOGIN STATUS: \(loginStatus)")
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("\(SimpleStateK.loginStatusChange)"),
                         object: nil,
                         queue: .main) { (_) in
                let status = UserDefaults.standard.value(forKey: "\(SimpleStateK.loginStatus)")
                loginStatus = CheckLoginStatus.checkStatus(loggedInStatus: status as! String)
        }
    }

    func showLoaderListener () {
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("\(SimpleStateK.showLoaderChange)"),
                         object: nil,
                         queue: .main) { (_) in
                let loaderStatus = UserDefaults.standard.value(forKey: "\(SimpleStateK.showLoader)")
                self.showLoader = loaderStatus as! Bool
        }
    }
}
