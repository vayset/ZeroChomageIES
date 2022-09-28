//
//  UserService.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation



final class UserService: ObservableObject {
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private let networkManager: NetworkManagerProtocol
    private let keychainService: KeychainServiceProtocol
    private let jsonEncoder: JSONEncoderProtocol
    
    
    
    // MARK: - Init
    
    init(
        networkManager: NetworkManagerProtocol = NetworkManager.shared,
        keychainService: KeychainServiceProtocol = KeychainService.shared,
        jsonEncoder: JSONEncoderProtocol = JSONEncoder()
    ) {
        self.networkManager = networkManager
        self.keychainService = keychainService
        self.jsonEncoder = jsonEncoder
    }
    
    // MARK: - Internal
    
    // MARK: - Properties
    
    @Published var cachedUser: User?
    static let shared = UserService()
    
    // MARK: - Methods
    
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
    
    func fetchUsers() async throws -> [User] {
        let url = URL(string: "http://localhost:8080/api/v1/users/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let userToken = try keychainService.getToken()
        request.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        guard let users: [User] = try? await networkManager.fetch(urlRequest: request) else {
            throw UserServiceError.failedToFetchUsers
        }
        
        return users
    }
    
    func validateProfile(user: User) async throws {
        let url = URL(string: "http://localhost:8080/api/v1/users/validate")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        let requestBody = ValidateUserBody(userToValidateEmail: user.email)
        
        guard let encodedBody = try? jsonEncoder.encode(requestBody) else {
            throw NewsArticlesServiceError.createNewsArticleFailedEncoding
        }
        
        request.httpBody = encodedBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let userToken = try keychainService.getToken()
        request.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        guard let _ = try? await networkManager.send(urlRequest: request) else {
            throw UserServiceError.failedToValidateUser
        }
    }
}
