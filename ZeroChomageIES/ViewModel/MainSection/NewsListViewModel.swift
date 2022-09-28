//
//  NewsListViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import Foundation

@MainActor
final class NewsListViewModel: ObservableObject {
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private let newsArticlesService: NewsArticlesServiceProtocol
    
    // MARK: - Init
    
    init(
        newsArticlesService: NewsArticlesServiceProtocol = NewsArticlesService.shared
    ) {
        self.newsArticlesService = newsArticlesService
    }
    
    // MARK: - Internal
    
    // MARK: - Properties
    
    var alertTitle = ""
    @Published var isAlertPresented = false
    @Published var isArticleDetailsPresented = false
    @Published var isLoading = false
    lazy var articleChomageCellViewModels: [GenericCellViewModel] = []
    var presentedArticle: Article? {
        didSet {
            isArticleDetailsPresented.toggle()
        }
    }
    
    // MARK: - Methods
    
    func fetchArticles() async {
        isLoading = true
        do {
            let articles = try await newsArticlesService.fetchArticles()
            let sortedArticled = articles.sorted { $0.createdAtDate > $1.createdAtDate }
            self.articleChomageCellViewModels = sortedArticled.map { article in
                GenericCellViewModel(
                    article: article,
                    iconSystemName: "doc.plaintext",
                    buttonTitle: Strings.cellButtonTitle,
                    buttonAction: { [weak self] in
                        self?.presentedArticle = article
                    }
                )
            }
        } catch {
            alertTitle = error.localizedDescription
            isAlertPresented.toggle()
        }
        isLoading = false
    }
}
