//
//  NewsListViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import Foundation

@MainActor
final class NewsListViewModel: ObservableObject {
    
    init(
        newsArticlesService: NewsArticlesServiceProtocol = NewsArticlesService.shared
    ) {
        self.newsArticlesService = newsArticlesService
    }

    
    var alertTitle = ""
    @Published var isAlertPresented = false
    
    func fetchArticles() async {
        isLoading = true
        
        do {
            let articles = try await newsArticlesService.fetchArticles()
            
         
            
            let sortedArticled = articles.sorted { $0.createdAtDate > $1.createdAtDate }
            
            self.articleChomageCellViewModels = sortedArticled.map { article in
                ChomageCellViewModel(
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
    
    var presentedArticle: Article? {
        didSet {
            isArticleDetailsPresented.toggle()
        }
    }
    
    @Published var isArticleDetailsPresented = false
    @Published var isLoading = false
    
    lazy var articleChomageCellViewModels: [ChomageCellViewModel] = []
    
    private let newsArticlesService: NewsArticlesServiceProtocol
    
}
