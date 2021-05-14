//
//  UserToVerifyVM.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/01/21.
//

import Foundation


class PreRegisteredUserVM:ObservableObject {
    @Published var user:PreRegisteredUser
    @Published var otp:String = ""
    @Published var sendToOTPView:Bool = false
    @Published var userLoggedIn:Bool = false

    @Published var showAlert:Bool = false
    @Published var alertMessage:String = ""

    private let AuthService:AuthenticateServiceProtocol
    private let findDocOrPatientVM:FindUserTypeViewModelProtocol

    init(AuthService: AuthenticateServiceProtocol = AuthenticateService(),
         findDocOrPatientVM:FindUserTypeViewModelProtocol = Logon()) {

        self.AuthService = AuthService
        self.findDocOrPatientVM = findDocOrPatientVM
        user = PreRegisteredUser(phNumberObj: PhoneNumberObj(), verificationId: "")
    }

    var phoneNumber:String {
        return user.phNumberObj.countryCode+user.phNumberObj.number.text
    }

    func validateNumWithFirebase() {
        LocalStorageHelper().storePhoneNumber(number: PhoneNumber(countryCode: self.user.phNumberObj.countryCode,
                                                                  number: self.user.phNumberObj.number.text,
                                                                  type: "",
                                                                  phoneNumberID: ""))
        
        AuthService.verifyNumber(phNumber: phoneNumber) { verificationId, errorString in
            CommonDefaultModifiers.hideLoader()
            if verificationId != nil {
                self.user.verificationId = verificationId!
                self.sendToOTPView.toggle()
            } else if errorString != nil {
                self.showAlert = true
                self.alertMessage = errorString!
                EndEditingHelper.endEditing()
            }
        }
    }

    func registerUser () {
        CommonDefaultModifiers.showLoader()
        AuthService.verifyUser(verificationId: self.user.verificationId, otp: self.otp) { (verified, errorString) in
            if verified == true {
                RetrieveAuthId().getAuthId { (success) in
                    if success {
                        self.loginUser()
                    }
                }
            } else if errorString != nil {
                CommonDefaultModifiers.hideLoader()
                self.showAlert = true
                self.alertMessage = errorString!
                EndEditingHelper.endEditing()
            }
        }
    }

    func loginUser () {
        self.userLoggedIn = true
        findDocOrPatientVM.logonUser() { (patientOrDoc) in
            CommonDefaultModifiers.hideLoader()
            switch patientOrDoc {
            case .ServiceProvider:
                LoginDefaultModifiers.signInDoctor(userId: self.AuthService.getUserId())
            case .Customer:
                LoginDefaultModifiers.signInPatient(userId: self.AuthService.getUserId())
            case .NotRegistered:
                LoginDefaultModifiers.takeToRegistration()
            case .NotSignedIn:
                return
            default:
                return
            }
        }
    }
}
