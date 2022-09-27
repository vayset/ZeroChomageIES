//
//  NewsListViewModelTests.swift
//  NewsListViewModelTests
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import XCTest
@testable import ZeroChomageIES

@MainActor
class NewsListViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        
    }


    func test_givenNewsListWithNoArticles_whenFetchArticles_thenNotEmptyArticles() async throws {
        
        let newsArticlesServiceMock = NewsArticlesServiceMock(isFetchArticlesFailing: false)
        
        let sut = NewsListViewModel(newsArticlesService: newsArticlesServiceMock)
        XCTAssertTrue(sut.articleChomageCellViewModels.isEmpty)
        await sut.fetchArticles()
        
        XCTAssertFalse(sut.articleChomageCellViewModels.isEmpty)
    }
    
    func test_givenNewsListWi_whenFetchArticles_thenNotEmptyArticles() async throws {
        
        let newsArticlesServiceMock = NewsArticlesServiceMock(isFetchArticlesFailing: false)
        let sut = NewsListViewModel(newsArticlesService: newsArticlesServiceMock)
        XCTAssertTrue(sut.articleChomageCellViewModels.isEmpty)
        await sut.fetchArticles()
        let firstFetchedArticle = try XCTUnwrap(sut.articleChomageCellViewModels.first)
        
        firstFetchedArticle.buttonAction()
        
        XCTAssertEqual(sut.presentedArticle!.titleNews, firstFetchedArticle.title)
    }
    
    
    
    func test_givenNewListViewModelWithBadFetchingService_whenFetchArticles_thenAlertIsPresented() async throws {
        
        let newsArticlesServiceMock = NewsArticlesServiceMock(isFetchArticlesFailing: true)
        let sut = NewsListViewModel(newsArticlesService: newsArticlesServiceMock)
        XCTAssertFalse(sut.isAlertPresented)
        
        await sut.fetchArticles()
    
        XCTAssertTrue(sut.isAlertPresented)
    }
    
}

