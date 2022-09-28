//
//  CreateArticleViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

@MainActor
final class CreateArticleViewModel: ObservableObject {
    
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private let newsArticlesService = NewsArticlesService.shared

    
    // MARK: - Internal
    
    // MARK: - Properties
    
    @Published var title = ""
    @Published var description = ""
    @Published var bodyArticle = ""
    @Published var isLoading = false
    @Published var isAlertPresented = false
    var alertTitle = ""

    // MARK: - Methods

    func onCreateNewsArticleButtonTapped() {
        let requestBody = CreateNewsArticleRequestBody(
            titleNews: title,
            descriptionNews: description,
            bodyNews: bodyArticle
        )
        Task {
            do {
                try await newsArticlesService.createNewsArticle(requestBody: requestBody)
                alertTitle = Strings.createArticlePopUpTitle
                isAlertPresented = true
            } catch {
                print("News article creation failed")
                alertTitle = Strings.createArticlePopUpTitleFailed
                isAlertPresented = true
            }
        }
    }
}
