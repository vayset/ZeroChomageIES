//
//  UserService.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation



final class UserService: ObservableObject{
    static let shared = UserService()
    
    @Published var cachedUser: User?
    
    func fetchUser() async throws -> User {
        let url = URL(string: "http://localhost:8080/api/v1/user-account-info/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue

    
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let userToken = try keychainService.getToken()
        request.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        guard let user: User = try? await networkManager.fetch(urlRequest: request) else {
            throw UserServiceError.failedToFetchUser
        }
        
        
        self.cachedUser = user
        
        return user
    }
    
    
    
    private let networkManager = NetworkManager.shared
    private let keychainService = KeychainService.shared
}
