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
    
    func login(email: String, password: String) async throws {
        let url = URL(string: "http://localhost:8080/api/v1/login/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        request.httpBody = try JSONEncoder().encode(loginRequest)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(String(data: request.httpBody!, encoding: .utf8))
        
        
        let loginResponse: LoginResponse = try await networkManager.fetch(urlRequest: request)
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    func fetch<T: Codable>(urlRequest: URLRequest) async throws -> T {
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        
        return decodedData
        
    }
}
