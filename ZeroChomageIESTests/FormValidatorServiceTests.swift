//
//  FormValidatorServiceTests.swift
//  ZeroChomageIESTests
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import XCTest
@testable import ZeroChomageIES

class FormValidatorServiceTests: XCTestCase {
    
    var sut: FormValidatorService!
    
    override func setUp() {
        sut = FormValidatorService()
    }
    
    
    // MARK: Email

    func test_givenValidEmail_whenValidateEmail_thenNoThrownError() throws {
        let email = "saddam@gmail.com"
        try sut.validate(email: email)
    }
    
    func test_givenInvalidEmailWithMissingAt_whenValidateEmail_thenGetFailedToValidateEmail() throws {
        let email = "saddamgmail.com"
        
        XCTAssertThrowsError(try sut.validate(email: email), "") { error in
            guard let error = error as? FormValidatorServiceError else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, .failedToValidateEmail)
        }
    }
    
    
    func test_givenInvalidRegularExpressionFactory_whenValidateEmail_thenGetFailedToValidateEmail() throws {
        sut = FormValidatorService(regularExpressionFactory: RegularExpressionFactoryMock())
        let email = "saddam@gmail.com"
        
        XCTAssertThrowsError(try sut.validate(email: email), "") { error in
            guard let error = error as? FormValidatorServiceError else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, .failedToValidateEmail)
        }
        
    }
    
    
    // MARK: Password
    
    func test_givenValidPassword_whenValidatePassword_thenNoThrownError() throws {
        let password = "MyPassword88!"
        try sut.validate(password: password)
        
    }
    
    
    
    
    func test_givenTooShortPassword_whenValidatePassword_thenGetFailedToValidatePassword() throws {
        let password = "mypass"
        
        XCTAssertThrowsError(try sut.validate(password: password), "") { error in
            guard let error = error as? FormValidatorServiceError else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, .failedToValidatePasswordWrongFormat)
        }
        
    }
    
    
    func test_givenPasswordLackSpecialCharacters_whenValidatePassword_thenGetFailedToValidatePassword() throws {
        let password = "MyPassword88"
        
        XCTAssertThrowsError(try sut.validate(password: password), "") { error in
            guard let error = error as? FormValidatorServiceError else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, .failedToValidatePasswordWrongFormat)
        }
        
    }
    
    
    
    func test_givenPasswordLackUppercasedCharacters_whenValidatePassword_thenGetFailedToValidatePassword() throws {
        let password = "mypassword88!"
        
        XCTAssertThrowsError(try sut.validate(password: password), "") { error in
            guard let error = error as? FormValidatorServiceError else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, .failedToValidatePasswordWrongFormat)
        }
        
    }
    
    
    
    
    
    
    
    func test_givenNotEmptyPassword_whenValidateNotEmptyPassword_thenNoThrownError() throws {
        let password = "MyPassword88!"
        try sut.validateNotEmptyPassword(password: password)
        
    }
    
    
    
    
    func test_givenPasswordEmpty_whenValidateNotEmptyPassword_thenGetFailedToValidatePasswordEmpty() throws {
        let password = ""
        
        XCTAssertThrowsError(try sut.validateNotEmptyPassword(password: password), "") { error in
            guard let error = error as? FormValidatorServiceError else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, .failedToValidatePasswordEmpty)
        }
        
    }


}


