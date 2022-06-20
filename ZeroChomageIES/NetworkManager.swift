//
//  NetworkManager.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 27/01/2022.
//

import Foundation
import ZeroChomageWebShared



class AuthenticationService {
    static let shared = AuthenticationService()
    
    private let networkManager = NetworkManager.shared
    private let userDefaultsManager = UserDefaultsManager.shared
    
    func login(email: String, password: String) async throws {
        let url = URL(string: "http://localhost:8080/api/v1/login/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        request.httpBody = try JSONEncoder().encode(loginRequest)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(String(data: request.httpBody!, encoding: .utf8))
        
        
        let loginResponse: LoginResponse = try await networkManager.fetch(urlRequest: request)
        
        userDefaultsManager.setUserToken(value: loginResponse.userToken)
    }
    
    
    func signUp(email: String, password: String) async throws {
        let url = URL(string: "http://localhost:8080/api/v1/signup/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let requestBody = SignUpRequest(email: email, password: password)
        
        request.httpBody = try JSONEncoder().encode(requestBody)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        

        
        let response: SignUpResponse = try await networkManager.fetch(urlRequest: request)
        
        userDefaultsManager.setUserToken(value: response.userToken)
    }
}
    

struct SignUpRequest: Encodable {
    let email: String
    let password: String
}

struct SignUpResponse: Codable {
    let userToken: String
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    func fetch<T: Codable>(urlRequest: URLRequest) async throws -> T {
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        
        return decodedData
        
    }
}
