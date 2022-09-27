//
//  KeychainServiceFailureMock.swift
//  KeychainServiceFailureMock
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

@testable import ZeroChomageIES


final class KeychainServiceFailureMock: KeychainServiceProtocol {
    func save(token: String) throws {
        throw KeychainServiceError.failedToStoreDataUnknownError
    }
    
    func getToken() throws -> String {
        throw KeychainServiceError.failedToGetTokenNotFound
    }
    
    func deleteToken() throws {
        throw KeychainServiceError.failedToDeleteToken
    }
    
    
}


