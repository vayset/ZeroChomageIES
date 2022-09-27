//
//  AuthenticationService.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation
import ZeroChomageWebShared


final class AuthenticationService {
    static let shared = AuthenticationService()
    
    private let networkManager = NetworkManager.shared
    private let keychainService = KeychainService.shared
    
    func login(email: String, password: String) async throws {
        let url = URL(string: "http://localhost:8080/api/v1/login/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        guard let encodedBody = try? JSONEncoder().encode(loginRequest) else {
            throw AuthenticationServiceError.loginFailedEncodingError
        }
        
        request.httpBody = encodedBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let response: LoginResponse = try? await networkManager.fetch(urlRequest: request) else {
            throw AuthenticationServiceError.loginFailed
        }
        
        guard let _ = try? keychainService.save(token: response.userToken) else {
            throw AuthenticationServiceError.loginFailedCouldNotStoreUserToken
        }
    }
    
    
    func signUp(email: String, password: String, passwordConfirmation: String) async throws {
        
        guard password == passwordConfirmation else {
            throw AuthenticationServiceError.signUpFailedPasswordAndConfirmationDontMatch
        }
        
        let url = URL(string: "http://localhost:8080/api/v1/signup/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        let requestBody = SignUpRequest(
            email: email,
            password: password,
            passwordConfirmation: passwordConfirmation
        )
        
        guard let encodedBody = try? JSONEncoder().encode(requestBody) else {
            throw AuthenticationServiceError.signUpFailedEncodingError
        }
        
        request.httpBody = encodedBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        

        guard let response: SignUpResponse = try? await networkManager.fetch(urlRequest: request) else {
            throw AuthenticationServiceError.signUpFailedNetworkError
        }
        
        guard let _ = try? keychainService.save(token: response.userToken) else {
            throw AuthenticationServiceError.signUpFailedCouldNotStoreUserToken
        }
    }
}
