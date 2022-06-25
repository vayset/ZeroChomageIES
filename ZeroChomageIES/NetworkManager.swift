//
//  NetworkManager.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 27/01/2022.
//

import Foundation
import ZeroChomageWebShared

enum AuthenticationServiceError: LocalizedError {
    case loginFailed
    case loginFailedEncodingError
    case loginFailedCouldNotStoreUserToken
    
    case signUpFailedPasswordAndConfirmationDontMatch
    case signUpFailedNetworkError
    case signUpFailedEncodingError
    case signUpFailedCouldNotStoreUserToken
    
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .loginFailed:
            return "La connexion a échoué."
        case .loginFailedEncodingError:
            return "L'encodage de la requête a échoué."
        case .loginFailedCouldNotStoreUserToken:
            return "Impossible de stocker le jeton d'identification"
        case .signUpFailedPasswordAndConfirmationDontMatch:
            return "Le mot de passe et sa confirmation ne correspondent pas."
        case .signUpFailedNetworkError:
            return "La création du compte a échoué."
        case .signUpFailedEncodingError:
            return "L'encodage de la requête a échoué."
        case .signUpFailedCouldNotStoreUserToken:
            return "Impossible de stocker le jeton d'identification"
        case .unknownError:
            return "Erreur inconnue."
        }
    }
    
}

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
    

struct SignUpRequest: Encodable {
    let email: String
    let password: String
    let passwordConfirmation: String
}

struct SignUpResponse: Codable {
    let userToken: String
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    func fetch<T: Codable>(urlRequest: URLRequest) async throws -> T {
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        
        return decodedData
        
    }
}




enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
