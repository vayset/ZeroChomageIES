//
//  NewsArticlesService.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

protocol NewsArticlesServiceProtocol {
    func createNewsArticle(requestBody: CreateNewsArticleRequestBody) async throws
    func fetchArticles() async throws -> [Article]
}

final class NewsArticlesService: NewsArticlesServiceProtocol {
    
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
    
    static let shared = NewsArticlesService()
    
    // MARK: - Methods
    
    func createNewsArticle(requestBody: CreateNewsArticleRequestBody) async throws {
        let url = URL(string: "http://localhost:8080/api/v1/news/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        
        guard let encodedBody = try? jsonEncoder.encode(requestBody) else {
            throw NewsArticlesServiceError.createNewsArticleFailedEncoding
        }
        
        request.httpBody = encodedBody
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let userToken = try keychainService.getToken()
        request.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        guard let _ = try? await networkManager.send(urlRequest: request) else {
            throw NewsArticlesServiceError.createNewsArticleFailedNetwork
        }
    }
    
    
    func fetchArticles() async throws -> [Article] {
        let url = URL(string: "http://localhost:8080/api/v1/news/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let userToken = try keychainService.getToken()
        request.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        guard let articles: [Article] = try? await networkManager.fetch(urlRequest: request) else {
            throw NewsArticlesServiceError.failedToFetchNewsArticles
        }
        return articles
    }
}

protocol JSONEncoderProtocol {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

extension JSONEncoder: JSONEncoderProtocol {
}
