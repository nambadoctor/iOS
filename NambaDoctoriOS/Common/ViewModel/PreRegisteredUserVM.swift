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
    private let AuthService:AuthenticateServiceProtocol
    private let findDocOrPatientVM:FindUserTypeViewModelProtocol

    init(AuthService: AuthenticateServiceProtocol = AuthenticateService(),
         findDocOrPatientVM:FindUserTypeViewModelProtocol = FindDocOrPatientVM()) {

        self.AuthService = AuthService
        self.findDocOrPatientVM = findDocOrPatientVM
        user = PreRegisteredUser(phNumberObj: PhoneNumberObj(), verificationId: "")
    }

    var phoneNumber:String {
        return user.phNumberObj.countryCode+user.phNumberObj.number
    }

    func checkNumberLength() -> Bool {
        return AuthService.validatePhoneNumber(user.phNumberObj.number)
    }
    
    func validateNumWithFirebase() {
        AuthService.verifyNumber(phNumber: phoneNumber) { verificationId in
            CommonDefaultModifiers.hideLoader()
            if verificationId != nil {
                self.user.verificationId = verificationId!
                self.sendToOTPView.toggle()
            } else {
                EndEditingHelper.endEditing()
                GlobalPopupHelpers.invalidNumberAlert()
            }
        }
    }

    func registerUser () {
        AuthService.verifyUser(verificationId: self.user.verificationId, otp: self.otp) { (verified) in
            if verified == true {
                self.loginUser()
            } else {
                GlobalPopupHelpers.incorrectOTPAlert()
            }
        }
    }

    func loginUser () {
        self.userLoggedIn = true
        findDocOrPatientVM.getDocOrPatient (phoneNumber: phoneNumber) { (patientOrDoc) in
            CommonDefaultModifiers.hideLoader()

            switch patientOrDoc {
            case .Doctor:
                LoginDefaultModifiers.signInDoctor(userId: self.AuthService.getUserId())
            case .Patient:
                LoginDefaultModifiers.signInPatient(userId: self.AuthService.getUserId())
            case .NotSignedIn:
                return
            default:
                return
            }
        }
    }
}
