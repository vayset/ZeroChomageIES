//
//  CreateArticleViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

@MainActor
final class CreateArticleViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var description = ""
    @Published var bodyArticle = ""
    @Published var isLoading = false
    
    var alertTitle = ""
    @Published var isAlertPresented = false
    
    
    
    func onCreateNewsArticleButtonTapped() {
        let requestBody = CreateNewsArticleRequestBody(
            titleNews: title,
            descriptionNews: description,
            bodyNews: bodyArticle
        )
        
        
        Task {
            do {
                try await newsArticlesService.createNewsArticle(requestBody: requestBody)
                alertTitle = "SUCCESS"
                isAlertPresented = true
                // TODO: Should display news article creation confirmation (or dismiss of the sheet)
            } catch {
                print("News article creation failed")
                alertTitle = "FAILED"
                isAlertPresented = true
                // TODO: Should display error alert
            }
        }
        
    }
    
    
    
    private let newsArticlesService = NewsArticlesService.shared
}
