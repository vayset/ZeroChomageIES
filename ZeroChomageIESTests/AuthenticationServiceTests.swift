//
//  AuthenticationServiceTests.swift
//  AuthenticationServiceTests
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import XCTest
@testable import ZeroChomageIES

@MainActor
class AuthenticationServiceTests: XCTestCase {
 

    func test_givenService_whenLogin_thenSuccess() async throws {
        
        let networkManagerMock = NetworkManagerAuthenticationMockSuccess(isLogin: true)
        let keychainServiceMock = KeychainServiceMock()
        
        let sut = AuthenticationService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        
        try await sut.login(email: "saddam@gmail.com", password: "123Password!")
        
    }
    
    
    func test_givenService_whenSignUp_thenSuccess() async throws {
        
        let networkManagerMock = NetworkManagerAuthenticationMockSuccess(isLogin: false)
        let keychainServiceMock = KeychainServiceMock()
        
        let sut = AuthenticationService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        
        try await sut.signUp(email: "saddam@gmail.com", password: "123Password!", passwordConfirmation: "123Password!")
        
    }
    
    
    
    func test_givenServiceBadEncoder_whenLogin_thenFailure() async throws {
        
        let networkManagerMock = NetworkManagerAuthenticationMockSuccess(isLogin: true)
        let keychainServiceMock = KeychainServiceMock()
        let jsonEncoderFailureMock = JsonEncoderMock()
        
        let sut = AuthenticationService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock,
            jsonEncoder: jsonEncoderFailureMock
        )
        
        
        
        do {
            try await sut.login(email: "saddam@gmail.com", password: "123Password!")
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
        
        
        
    }
    
    
    func test_givenServiceBadEncoder_whenSignUp_thenFailure() async throws {
        
        let networkManagerMock = NetworkManagerAuthenticationMockSuccess(isLogin: false)
        let keychainServiceMock = KeychainServiceMock()
        let jsonEncoderFailureMock = JsonEncoderMock()
        
        let sut = AuthenticationService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock,
            jsonEncoder: jsonEncoderFailureMock
        )
        
        
        do {
            try await sut.signUp(email: "saddam@gmail.com", password: "123Password!", passwordConfirmation: "123Password!")
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
        
    }
    
    
    
    func test_givenServiceBadNetwork_whenLogin_thenFailure() async throws {
        
        let networkManagerMock = NetworkManagerMockFailure()
        let keychainServiceMock = KeychainServiceMock()
        
        let sut = AuthenticationService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        
        
        do {
            try await sut.login(email: "saddam@gmail.com", password: "123Password!")
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
        
        
        
    }
    
    
    func test_givenServiceBadNetwork_whenSignUp_thenFailure() async throws {
        
        let networkManagerMock = NetworkManagerMockFailure()
        let keychainServiceMock = KeychainServiceMock()
        
        let sut = AuthenticationService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        
        do {
            try await sut.signUp(email: "saddam@gmail.com", password: "123Password!", passwordConfirmation: "123Password!")
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
        
    }
    
    
    
    
    
    
    func test_givenServiceBadKeychain_whenLogin_thenFailure() async throws {
        
        let networkManagerMock = NetworkManagerAuthenticationMockSuccess(isLogin: true)
        let keychainServiceMock = KeychainServiceFailureMock()
        
        let sut = AuthenticationService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        
        
        do {
            try await sut.login(email: "saddam@gmail.com", password: "123Password!")
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
        
        
        
    }
    
    
    func test_givenServiceBadKeychain_whenSignUp_thenFailure() async throws {
        
        let networkManagerMock = NetworkManagerAuthenticationMockSuccess(isLogin: false)
        let keychainServiceMock = KeychainServiceFailureMock()
        
        let sut = AuthenticationService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        
        do {
            try await sut.signUp(email: "saddam@gmail.com", password: "123Password!", passwordConfirmation: "123Password!")
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
        
    }
    
    func test_givenPasswordDifferentThanConfirmation_whenSignUp_thenFailure() async throws {
        
        
        let sut = AuthenticationService()
        
        
        do {
            try await sut.signUp(email: "saddam@gmail.com", password: "123Password!!", passwordConfirmation: "123Password!")
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
        
    }
    

    
}









