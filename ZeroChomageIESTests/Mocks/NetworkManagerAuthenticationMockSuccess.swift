//
//  NetworkManagerAuthenticationMockSuccess.swift
//  NetworkManagerAuthenticationMockSuccess
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

@testable import ZeroChomageIES
import ZeroChomageWebShared


final class NetworkManagerAuthenticationMockSuccess: NetworkManagerProtocol {
    
    init(
        isLogin: Bool
    ) {
        self.isLogin = isLogin
    }
    
    let isLogin: Bool
    
    func fetch<T>(urlRequest: URLRequest) async throws -> T where T : Decodable, T : Encodable {
        if isLogin {
            return LoginResponse(userToken: "123token") as! T
        } else {
            return SignUpResponse(userToken: "123token") as! T
        }
    }
    
    func send(urlRequest: URLRequest) async throws {
        
    }

}
