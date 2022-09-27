//
//  UserServiceTests.swift
//  UserServiceTests
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import XCTest
@testable import ZeroChomageIES

@MainActor
class UserServiceTests: XCTestCase {
 

    func test_givenService_whenFetchSingleUser_thenSuccess() async throws {
        
        let networkManagerMock = NetworkManagerUserMockSuccess(isMultipleUser: false)
        let keychainServiceMock = KeychainServiceMock()
        
        let sut = UserService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        
        _ = try await sut.fetchUser()
    }
    
    
    func test_givenService_whenFetchMultipleUsers_thenSuccess() async throws {
        
        let networkManagerMock = NetworkManagerUserMockSuccess(isMultipleUser: true)
        let keychainServiceMock = KeychainServiceMock()
        
        let sut = UserService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        
        _ = try await sut.fetchUsers()
    }
    
    
    
    func test_givenService_whenValidateUser_thenSuccess() async throws {
        
        let networkManagerMock = NetworkManagerUserMockSuccess(isMultipleUser: true)
        let keychainServiceMock = KeychainServiceMock()
        
        let sut = UserService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        let userToValidate = User(id: nil, firstname: "saddam", email: "s@gmail.com", passwordHash: "", lastName: "satouyev", address: nil, zipCode: nil, city: nil, phoneNumber: nil, dateOfBirth: nil, gender: nil, civilStatus: nil, isAdmin: false, isAlreadyFilled: true, isValidated: false)
        
        
        _ = try await sut.validateProfile(user: userToValidate)
    }
    
    

    
}
