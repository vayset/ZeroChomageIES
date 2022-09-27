//
//  NetworkManager.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 27/01/2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetch<T: Codable>(urlRequest: URLRequest) async throws -> T
    func send(urlRequest: URLRequest) async throws
}


final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    
    func fetch<T: Codable>(urlRequest: URLRequest) async throws -> T {
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        
        return decodedData
        
    }
    
    
    func send(urlRequest: URLRequest) async throws {
        
        guard let (_, response) = try? await URLSession.shared.data(for: urlRequest) else {
            throw NetworkManagerError.unknownError
        }
        
        guard let response = response as? HTTPURLResponse,
              200...299 ~= response.statusCode 
        else {
            throw NetworkManagerError.invalidHttpUrlResponse
        }
        
    }
}




