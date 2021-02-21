//
//  AuthenticationServiceTests.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 20/01/21.
//

import XCTest
@testable import NambaDoctoriOS

class LoginViewModelTests: XCTestCase {
    
    var loginViewModel: PreRegisteredUserVM!
    var mockAuthService: MockAuthenticateService!

    override func setUp() {
        mockAuthService = MockAuthenticateService()
        loginViewModel = .init(AuthService: mockAuthService)
    }

    //testing phone number verification
    func testLoginWithCorrectDetailsReturnsSuccess () {
        loginViewModel.validateNumWithFirebase()
        
        XCTAssertEqual(loginViewModel.user.verificationId, "verificationId")
    }

    func testLoginWithInCorectDetailsReturnsFailure () {
        mockAuthService.numVerified = nil
        loginViewModel.validateNumWithFirebase()

        XCTAssertEqual(loginViewModel.user.verificationId, "")
    }
    
    //testing user verification
    func testUserVerificationWithCorrectOTPReturnsSuccess () {
        loginViewModel.registerUser()
        
        XCTAssertTrue(loginViewModel.userLoggedIn)
    }

    func testUserVerificationWithInCorrectOTPReturnsFailure () {
        mockAuthService.userVerified = false
        loginViewModel.registerUser()
        
        XCTAssertFalse(loginViewModel.userLoggedIn)
    }
}
