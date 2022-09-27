//
//  NewsArticlesServiceTests.swift
//  NewsArticlesServiceTests
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import XCTest
@testable import ZeroChomageIES

@MainActor
class NewsArticlesServiceTests: XCTestCase {
 

    func test_givenService_whenCreateNewsArtcle_thenSuccess() async throws {
        
        let networkManagerMock = NetworkManagerArticleMockSuccess()
        let keychainServiceMock = KeychainServiceMock()
        
        let sut = NewsArticlesService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        let requestBody = CreateNewsArticleRequestBody(
            titleNews: "",
            descriptionNews: "",
            bodyNews: ""
        )
        
        try await sut.createNewsArticle(requestBody: requestBody)
        
    }
    
    func test_givenService_whenFetchArticles_thenSuccess() async throws {
        
        let networkManagerMock = NetworkManagerArticleMockSuccess()
        let keychainServiceMock = KeychainServiceMock()
        
        let sut = NewsArticlesService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        _ = try await sut.fetchArticles()
        
    }
    
    
    
    
    
    
    func test_givenServiceFailure_whenCreateNewsArtcle_thenFailure() async throws {
        
        let networkManagerMock = NetworkManagerMockFailure()
        let keychainServiceMock = KeychainServiceMock()
        
        let sut = NewsArticlesService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        let requestBody = CreateNewsArticleRequestBody(
            titleNews: "",
            descriptionNews: "",
            bodyNews: ""
        )
        
        do {
            try await sut.createNewsArticle(requestBody: requestBody)
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
        
    }
    
    func test_givenServiceFAilure_whenFetchArticles_thenFailure() async throws {
        
        let networkManagerMock = NetworkManagerMockFailure()
        let keychainServiceMock = KeychainServiceMock()
        
        let sut = NewsArticlesService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock
        )
        
        do {
            _ = try await sut.fetchArticles()
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
        
    }
    
    func test_givenServiceFailureEncoding_whenCreateNewArticles_thenFailure() async throws {
        
        let networkManagerMock = NetworkManagerMockFailure()
        let keychainServiceMock = KeychainServiceMock()
        let jsonEncoderFailMock = JsonEncoderMock()
        
        let sut = NewsArticlesService(
            networkManager: networkManagerMock,
            keychainService: keychainServiceMock,
            jsonEncoder: jsonEncoderFailMock
        )
        
        let requestBody = CreateNewsArticleRequestBody(
            titleNews: "",
            descriptionNews: "",
            bodyNews: ""
        )
        
        
        do {
            _ = try await sut.createNewsArticle(requestBody: requestBody)
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
        
    }
    

    
}









