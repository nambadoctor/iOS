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
    @State private var loaderCompleted:Bool = false
    @State private var showSnackBar:Bool = false

    var body: some View {
        ZStack {
            VStack {
                switch loginStatus {
                case .ServiceProvider:
                    ServiceProviderHome(serviceProviderHomeVM: .init())
                case .Customer:
                    CustomerHome(customerVM: .init())
                case .NotSignedIn:
                    NewInstallDoctorsPreviewView()
                case .TakeToSignin:
                    PhoneVerificationview(preRegUser: .init())
                case .NotRegistered:
                    CreateCustomerProfileView()
                }
            }
        }
        .overlay(LoadingScreen(showLoader: self.$showLoader, completed: self.$loaderCompleted))
        .modifier(Popup(isPresented: self.$showSnackBar, alignment: .bottom, direction: .bottom))
        .onAppear() {
            loginStateListener()
            showLoaderListener()
            showSnackBarListener()
        }
    }
}

//MARK: STATE CHANGE OBSERVERS
extension ContentView {
    func loginStateListener () {
        //Opening value check
        let status = UserTypeHelper.getUserType()
        if CheckLoginStatus.checkStatus(loggedInStatus: status) == .NotSignedIn {
            AuthenticateService().anonymousSignIn { success in
                if success {
                    loginStatus = CheckLoginStatus.checkStatus(loggedInStatus: status)
                }
            }
        } else {
            loginStatus = CheckLoginStatus.checkStatus(loggedInStatus: status)
        }

        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("\(SimpleStateK.loginStatusChange)"),
                         object: nil,
                         queue: .main) { (_) in
                let status = UserDefaults.standard.value(forKey: "\(SimpleStateK.loginStatus)")
                loginStatus = CheckLoginStatus.checkStatus(loggedInStatus: status as! String)
                print("STATUS SETTING: \(loginStatus)")
            }
    }
    
    func showLoaderListener () {
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("\(SimpleStateK.showLoaderChange)"),
                         object: nil,
                         queue: .main) { (_) in
                let loaderStatus = UserDefaults.standard.value(forKey: "\(SimpleStateK.showLoader)")  as! Bool
                
                if loaderStatus {
                    self.showLoader = loaderStatus
                } else {
                    self.loaderCompleted = true
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                        self.loaderCompleted = false
                        self.showLoader = false
                    }
                }
            }
    }
    
    func showSnackBarListener () {
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("\(SimpleStateK.showSnackbarChange)"),
                         object: nil,
                         queue: .main) { (_) in
                self.showSnackBar = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    self.showSnackBar = false
                }
            }
    }
}
