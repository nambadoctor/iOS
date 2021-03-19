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
         findDocOrPatientVM:FindUserTypeViewModelProtocol = Logon()) {

        self.AuthService = AuthService
        self.findDocOrPatientVM = findDocOrPatientVM
        user = PreRegisteredUser(phNumberObj: PhoneNumberObj(), verificationId: "")
    }

    var phoneNumber:String {
        return user.phNumberObj.countryCode+user.phNumberObj.number.text
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
        
        let custPhNumber = Nd_V1_CustomerPhoneNumber.with {
            $0.countryCode = user.phNumberObj.countryCode.toProto
            $0.number = user.phNumberObj.number.text.toProto
        }

        findDocOrPatientVM.logonUser(phoneNumber: custPhNumber) { (patientOrDoc) in
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
