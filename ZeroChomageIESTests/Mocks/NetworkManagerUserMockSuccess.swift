//
//  NetworkManagerAuthenticationMockSuccess.swift
//  NetworkManagerAuthenticationMockSuccess
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

@testable import ZeroChomageIES
import ZeroChomageWebShared


final class NetworkManagerUserMockSuccess: NetworkManagerProtocol {
    
    init(
        isMultipleUser: Bool
    ) {
        self.isMultipleUser = isMultipleUser
    }
    
    let isMultipleUser: Bool
    
    func createUser() -> User {
        User(id: nil, firstname: "saddam", email: "s@gmail.com", passwordHash: "", lastName: "satouyev", address: nil, zipCode: nil, city: nil, phoneNumber: nil, dateOfBirth: nil, gender: nil, civilStatus: nil, isAdmin: false, isAlreadyFilled: true, isValidated: false)
    }
    
    func fetch<T>(urlRequest: URLRequest) async throws -> T where T : Decodable, T : Encodable {
        if isMultipleUser {
            return [
                createUser(),
                createUser()
            ] as! T
        } else {
            return createUser() as! T
        }
    }
    
    func send(urlRequest: URLRequest) async throws {
        
    }

}
