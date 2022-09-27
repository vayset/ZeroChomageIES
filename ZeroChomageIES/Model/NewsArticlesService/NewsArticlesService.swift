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
    static let shared = NewsArticlesService()
    
    
    init(
        networkManager: NetworkManagerProtocol = NetworkManager.shared,
        keychainService: KeychainServiceProtocol = KeychainService.shared
    ) {
        self.networkManager = networkManager
        self.keychainService = keychainService
    }
    
    
    func createNewsArticle(requestBody: CreateNewsArticleRequestBody) async throws {
        let url = URL(string: "http://localhost:8080/api/v1/news/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        
        guard let encodedBody = try? JSONEncoder().encode(requestBody) else {
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
    
    
    private let networkManager: NetworkManagerProtocol
    private let keychainService: KeychainServiceProtocol
    
}
