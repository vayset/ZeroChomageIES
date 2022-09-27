//
//  NewsArticlesServiceMock.swift
//  ZeroChomageIESTests
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

@testable import ZeroChomageIES

final class NewsArticlesServiceMock: NewsArticlesServiceProtocol {
    
    let isFetchArticlesFailing: Bool
    
    init(
        isFetchArticlesFailing: Bool
    ) {
        self.isFetchArticlesFailing = isFetchArticlesFailing
    }
    
    func createNewsArticle(requestBody: CreateNewsArticleRequestBody) async throws {
        
    }
    
    func fetchArticles() async throws -> [Article] {
        guard !isFetchArticlesFailing else {
            throw NewsArticlesServiceError.failedToFetchNewsArticles
        }
        
        return [
            .init(
                backgroundImageName: nil,
                titleNews: "Title News",
                descriptionNews: "Description News",
                bodyNews: "Body News",
                createdAt: "2019-09-07T-15:50+00"
            ),
            .init(
                backgroundImageName: nil,
                titleNews: "Title News",
                descriptionNews: "Description News",
                bodyNews: "Body News",
                createdAt: "2019-09-07T-15:50+00"
            ),
        ]
    }
    
    
}
