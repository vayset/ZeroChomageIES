//
//  NewsListViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import Foundation

@MainActor

final class NewsListViewModel: ObservableObject {
    
    func fetchArticles() async {
        
        
        isLoading = true
        
        do {
            let articles = try await newsArticlesService.fetchArticles()
            
            self.articleChomageCellViewModels = articles.map { article in
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
            return // TODO: Should display alert
        }
        
        
        isLoading = false
        
        
    }
    
//    private var articles: [Article] = [
//        .init(
//            backgroundImageName: "work_image",
//            title: "Hired 1000 persons!",
//            description: "This company is fool... it has hired more than 1000 in a month.",
//            body: "It was the 15th of may bla bla bla (long article généré par GPT3)"
//        ),
//        .init(
//            backgroundImageName: "work_image",
//            title: "Fire 1000 persons!",
//            description: "This company is fool... it has hired more than 1000 in a month.",
//            body: "It was the 15th of may bla bla bla (long article généré par GPT3)"
//        ),
//        .init(
//            backgroundImageName: "work_image",
//            title: "Hired 0 persons!",
//            description: "This company is fool... it has hired more than 1000 in a month.",
//            body: "It was the 15th of may bla bla bla (long article généré par GPT3)"
//        )
//    ]
    
    var presentedArticle: Article? {
        didSet {
            isArticleDetailsPresented.toggle()
        }
    }
    @Published var isArticleDetailsPresented = false
    
    @Published var isLoading = false
    
    lazy var articleChomageCellViewModels: [ChomageCellViewModel] = [
//        fakeNews01CellViewModel,
//        fakeNews02CellViewModel,
//        fakeNews03CellViewModel
    ]
    
    
//
//    private lazy var fakeNews01CellViewModel = ChomageCellViewModel(
//        article: articles[0],
//        iconSystemName: "doc.plaintext",
//        buttonTitle: "Read",
//        buttonAction: { [weak self] in
//            self?.presentedArticle = self?.articles[0]
//        }
//    )
//
//
//    private lazy var fakeNews02CellViewModel = ChomageCellViewModel(
//        article: articles[1],
//        iconSystemName: "doc.plaintext",
//        buttonTitle: "Read",
//        buttonAction: { [weak self] in
//            self?.presentedArticle = self?.articles[1]
//        }
//    )
//
//
//    private lazy var fakeNews03CellViewModel = ChomageCellViewModel(
//        article: articles[2],
//        iconSystemName: "doc.plaintext",
//        buttonTitle: "Read",
//        buttonAction: { [weak self] in
//            self?.presentedArticle = self?.articles[2]
//        }
//    )
    
    
    private let newsArticlesService = NewsArticlesService.shared
    
}
