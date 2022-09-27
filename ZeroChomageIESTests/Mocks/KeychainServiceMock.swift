//
//  KeychainServiceMock.swift
//  ZeroChomageIESTests
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

@testable import ZeroChomageIES


final class KeychainServiceMock: KeychainServiceProtocol {
    func save(token: String) throws {
        
    }
    
    func getToken() throws -> String {
        return "test-token"
    }
    
    func deleteToken() throws {
        
    }
    
    
}


